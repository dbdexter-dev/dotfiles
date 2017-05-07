require 'cairo'

font = 'SFNS Display'
font_size = 24
smallfont_size = 12
interline = 5
red,green,blue = 1,1,1
inactiveAlpha,activeAlpha = 0.2,1
line_width = 5
font_slant = CAIRO_FONT_SLANT_NORMAL
font_face = CAIRO_FONT_WEIGHT_NORMAL
ring_x,ring_y = 275, 0
ring_radius = 50
clock_x,clock_y = 0, 55

load_max = 4
temp_max = 100
up_max = 300	-- kb/s
down_max = 3000	-- kb/s

function conky_main()
	if conky_window == nil then
		return
	end

	local cs = cairo_xlib_surface_create(conky_window.display,
										 conky_window.drawable,
										 conky_window.visual,
										 conky_window.width,
										 conky_window.height)
	cr = cairo_create(cs)

	local updates = tonumber(conky_parse('${updates}'))
	if updates > 1 then
		cairo_select_font_face(cr, font, font_slant, font_face)
		cairo_set_source_rgba(cr, red, green, blue, activeAlpha)
		cairo_set_line_width(cr, line_width)
		cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND)

		load_gauge(cr, ring_x, ring_y+ring_radius+line_width, ring_radius)
		temp_gauge(cr, ring_x, ring_y+ring_radius+line_width+2*ring_radius, ring_radius-line_width)
		mem_gauge(cr, ring_x, ring_y+ring_radius+2*line_width+4*ring_radius, ring_radius-line_width)
		net_gauge(cr, ring_x, ring_y+ring_radius+4*line_width+6*ring_radius, ring_radius)

		cairo_set_font_size(cr, smallfont_size)
	end

	if updates > 3 then
		cairo_set_font_size(cr, font_size)

		clock(cr, clock_x, clock_y)
		cairo_stroke(cr)
	end


	cairo_destroy(cr)
	cairo_surface_destroy(cs)
	cr = nil

end
function clamp(val, max)
	if val > max then
		return max
	end
	return val
end

function load_gauge(cr, x, y, radius)
	local scale = math.pi/load_max

	local minute1_angle = clamp(tonumber(conky_parse('${loadavg 1}')), load_max)*scale
	local minute5_angle = clamp(tonumber(conky_parse('${loadavg 2}')), load_max)*scale
	local minute15_angle = clamp(tonumber(conky_parse('${loadavg 3}')), load_max)*scale
	local line_width = line_width*1.1

	cairo_set_font_size(cr, smallfont_size)
	cairo_move_to(cr, x-14, y)
	cairo_show_text(cr, conky_parse('${loadavg 1}'))

	cairo_set_source_rgba(cr, 0.55, 0.76, 0.29, activeAlpha)
	cairo_move_to(cr, x, y-radius)
	cairo_arc(cr, x, y, radius, -math.pi/2, (minute1_angle - math.pi/2))
	cairo_stroke(cr)

	cairo_set_source_rgba(cr, 0.48, 0.70, 0.26, activeAlpha)
	cairo_move_to(cr, x, y-radius+line_width)
	cairo_arc(cr, x, y, radius-line_width, -math.pi/2, (minute5_angle - math.pi/2))
	cairo_stroke(cr)

	cairo_set_source_rgba(cr, 0.33, 0.55, 0.18, activeAlpha)
	cairo_move_to(cr, x, y-radius+2*line_width)
	cairo_arc(cr, x, y, radius-2*line_width, -math.pi/2, (minute15_angle - math.pi/2))
	cairo_stroke(cr)
end

function temp_gauge(cr, x, y, radius)
	local temp = tonumber(conky_parse('${hwmon 1 temp 1}'))
	cairo_set_font_size(cr, smallfont_size)
	cairo_set_source_rgba(cr, red, green, blue, activeAlpha)
	cairo_move_to(cr, x-17, y)
	cairo_show_text(cr, temp.."°C")

	local temp_angle = clamp(temp, temp_max)/temp_max*math.pi

	cairo_set_source_rgba(cr, 0.90, 0.22, 0.21, activeAlpha)
	cairo_move_to(cr, x, y-radius)
	cairo_arc(cr, x, y, radius, -math.pi/2, (temp_angle - math.pi/2))
	cairo_stroke(cr)
end

function mem_gauge(cr, x, y, radius)
	local memperc = tonumber(conky_parse('${memperc}'))
	cairo_set_font_size(cr, smallfont_size)
	cairo_set_source_rgba(cr, red, green, blue, activeAlpha)
	cairo_move_to(cr, x-24, y)
	cairo_show_text(cr, conky_parse('${mem}'))

	local mem_angle = memperc/100*math.pi

	cairo_set_source_rgba(cr, 0.99, 0.84, 0.21, activeAlpha)
	cairo_move_to(cr, x, y-radius)
	cairo_arc(cr, x, y, radius, -math.pi/2, (mem_angle - math.pi/2))
	cairo_stroke(cr)

end

function net_gauge(cr, x, y, radius)

	local upkb = tonumber(conky_parse('${upspeedf wlp58s0}'))
	local downkb = tonumber(conky_parse('${downspeedf wlp58s0}'))

	local up_angle = (1-clamp(upkb, up_max)/up_max)*math.pi
	local down_angle = clamp(downkb, down_max)/down_max*math.pi

	cairo_set_font_size(cr, smallfont_size)
	cairo_set_source_rgba(cr, red, green, blue, activeAlpha)
	cairo_move_to(cr, x-24, y-smallfont_size/2)
	cairo_show_text(cr, conky_parse('${downspeed wlp58s0}'))
	cairo_move_to(cr, x-24, y+smallfont_size/2)
	cairo_show_text(cr, conky_parse('${upspeed wlp58s0}'))

	cairo_set_source_rgba(cr, 0.16, 0.63, 0.87, activeAlpha)
	cairo_move_to(cr, x, y-radius)
	cairo_arc(cr, x, y, radius, -math.pi/2, (down_angle - math.pi/2))
	cairo_stroke(cr)

	cairo_move_to(cr, x, y+radius-line_width)
	cairo_set_source_rgba(cr, 0.96, 0.49, 0, activeAlpha)
	cairo_arc_negative(cr, x, y, radius-line_width, math.pi/2, (up_angle-math.pi/2))
	cairo_stroke(cr)

end

function clock(cr, x, y)
	local hour = tonumber(conky_parse('${exec date +"%I"}'))
	local minute = tonumber(conky_parse('${exec date +"%M"}'))

	local oclock,five,ten,quarter,twenty,half,past,to = false,false,false,false,false,false,false,false
	local hrone,hrtwo,hrthree,hrfour,hrfive,hrsix = false,false,false,false,false,false
	local hrseven,hreight,hrnine,hrten,hreleven,hrtwelve = false,false,false,false,false,false

	if minute < 5 then
		oclock = true
	elseif minute < 10 or minute > 55 then
		five = true
	elseif minute < 15 or minute > 50 then
		ten = true
	elseif minute < 20 or minute > 45 then
		quarter = true
	elseif minute < 30 or minute >= 35 then
		twenty = true
		if minute >= 25 and minute < 40 then
			five = true
		end
	else
		half = true
	end

	if minute < 35 then
		if minute >= 5 then
			past = true
		end
	else
		to = true
	end

	if (hour == 1 and to == false) or (hour == 12 and to == true) then
		hrone = true
	elseif (hour == 2 and to == false) or (hour == 1 and to == true) then
		hrtwo = true
	elseif (hour == 3 and to == false) or (hour == 2 and to == true) then
		hrthree = true
	elseif (hour == 4 and to == false) or (hour == 3 and to == true) then
		hrfour = true
	elseif (hour == 5 and to == false) or (hour == 4 and to == true) then
		hrfive = true
	elseif (hour == 6 and to == false) or (hour == 5 and to == true) then
		hrsix = true
	elseif (hour == 7 and to == false) or (hour == 6 and to == true) then
		hrseven = true
	elseif (hour == 8 and to == false) or (hour == 7 and to == true) then
		hreight = true
	elseif (hour == 9 and to == false) or (hour == 8 and to == true) then
		hrnine = true
	elseif (hour == 10 and to == false) or (hour == 9 and to == true) then
		hrten = true
	elseif (hour == 11 and to == false) or (hour == 10 and to == true) then
		hreleven = true
	elseif (hour == 12 and to == false) or (hour == 11 and to == true) then
		hrtwelve = true
	end


	cairo_move_to(cr, x, y+(font_size+interline))
	clock_show_text(cr, "IT", true)
	clock_show_text(cr, "L", false)
	clock_show_text(cr, "IS", true)
	clock_show_text(cr, "ASTIME", false)
	cairo_move_to(cr, x, y+(font_size+interline)*2)
	clock_show_text(cr, "A", quarter)
	clock_show_text(cr, "C", false)
	clock_show_text(cr, "QUARTER", quarter)
	clock_show_text(cr, "DI", false)
	cairo_move_to(cr, x, y+(font_size+interline)*3)
	clock_show_text(cr, "TWENTY", twenty)
	clock_show_text(cr, "FIVE", five)
	clock_show_text(cr, "X", false)
	cairo_move_to(cr, x, y+(font_size+interline)*4)
	clock_show_text(cr, "HALF", half)
	clock_show_text(cr, "B", false)
	clock_show_text(cr, "TEN", ten)
	clock_show_text(cr, "F", false)
	clock_show_text(cr, "TO", to)
	cairo_move_to(cr, x, y+(font_size+interline)*5)
	clock_show_text(cr, "PAST", past)
	clock_show_text(cr, "ERU", false)
	clock_show_text(cr, "NINE", hrnine)
	cairo_move_to(cr, x, y+(font_size+interline)*6)
	clock_show_text(cr, "ONE", hrone)
	clock_show_text(cr, "SIX", hrsix)
	clock_show_text(cr, "THREE", hrthree)
	cairo_move_to(cr, x, y+(font_size+interline)*7)
	clock_show_text(cr, "FOUR", hrfour)
	clock_show_text(cr, "FIVE", hrfive)
	clock_show_text(cr, "TWO", hrtwo)
	cairo_move_to(cr, x, y+(font_size+interline)*8)
	clock_show_text(cr, "EIGHT", hreight)
	clock_show_text(cr, "ELEVEN", hreleven)
	cairo_move_to(cr, x, y+(font_size+interline)*9)
	clock_show_text(cr, "SEVEN", hrseven)
	clock_show_text(cr, "TWELVE", hrtwelve)
	cairo_move_to(cr, x, y+(font_size+interline)*10)
	clock_show_text(cr, "TEN", hrten)
	clock_show_text(cr, "SE", false)
	clock_show_text(cr, "OCLOCK", oclock)

end

function clock_show_text(cr, str, isActive)
	if isActive == true then
		cairo_set_source_rgba(cr, red, green, blue, activeAlpha)
	else
		cairo_set_source_rgba(cr, red, green, blue, inactiveAlpha)
	end

	local str = str:gsub(".", "%1 ")--:sub(1, -2)
	cairo_show_text(cr, str)
end
