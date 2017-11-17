" Some simple plugin stems
function CommentLine()
	let l:firstChar = matchstr(getline('.'), '\S')
	let l:commentChars = split(&commentstring, '%s')

	if exists("l:commentChars[0]") && (l:firstChar != l:commentChars[0])
		exe 'normal' '0i' . l:commentChars[0]
		if exists("l:commentChars[1]")
			exe 'normal' 'A ' . l:commentChars[1]
		end
	end
endfunction
