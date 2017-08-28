"=======================================================
" Title: Material design colorscheme for lightline
" Note: This uses the native terminal color palette, so
"		all RGB hex values are set to full black
"=======================================================

let s:baseDarkest =		[ '#000000', 0]
let s:baseDark =		[ '#000000', 8]
let s:baseLight =		[ '#000000', 7]
let s:baseLightest =	[ '#000000', 15]

if &background == "light"
	let s:baseTemp1 =		s:baseDarkest
	let s:baseTemp2 =		s:baseDark
	let s:baseDarkest =		s:baseLightest
	let s:baseDark =		s:baseLight
	let s:baseLight =		s:baseTemp2
	let s:baseLightest =	s:baseTemp1
endif

let s:red =				[ '#000000', 1]
let s:green =			[ '#000000', 2]
let s:orange =			[ '#000000', 3]
let s:blue =			[ '#000000', 4]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:baseDarkest, s:baseLightest ], [ s:baseLightest, s:baseDark ] ]
let s:p.normal.right = [ [ s:baseDarkest, s:baseLightest ], [ s:baseLightest, s:baseDark ] ]
let s:p.normal.middle = [ [ s:baseLight, s:baseDarkest ] ]
let s:p.normal.ok = [ [ s:baseDarkest, s:green ] ]
let s:p.normal.error = [ [ s:baseDarkest, s:red ] ]
let s:p.normal.warning = [ [ s:baseDarkest, s:orange ] ]

let s:p.inactive.right = [ [ s:baseLight, s:baseDarkest ], [ s:baseLight, s:baseDarkest ] ]
let s:p.inactive.left =  [ [ s:baseLight, s:baseDarkest ], [ s:baseLight, s:baseDarkest ] ]
let s:p.inactive.middle = [ [ s:baseDark, s:baseDarkest] ]
let s:p.inactive.ok = [ [ s:baseDarkest, s:green ] ]
let s:p.inactive.error = [ [ s:baseDarkest, s:red ] ]
let s:p.inactive.warning = [ [ s:baseDarkest, s:orange ] ]

let s:p.replace.left = [ [ s:baseDarkest, s:red ], [ s:baseLightest, s:baseDark ], [ s:red, s:baseDarkest ] ]
let s:p.replace.right = [ [ s:baseDarkest, s:red ], [ s:baseLightest, s:baseDark ], [ s:red, s:baseDarkest ] ]
let s:p.replace.ok = [ [ s:baseDarkest, s:green ] ]
let s:p.replace.error = [ [ s:baseDarkest, s:red ] ]
let s:p.replace.warning = [ [ s:baseDarkest, s:orange ] ]

let s:p.insert.left = [ [ s:baseDarkest, s:blue ], [ s:baseLightest, s:baseDark ], [ s:blue, s:baseDarkest ] ]
let s:p.insert.right = [ [ s:baseDarkest, s:blue ], [ s:baseLightest, s:baseDark ], [ s:blue, s:baseDarkest ] ]
let s:p.insert.ok = [ [ s:baseDarkest, s:green ] ]
let s:p.insert.error = [ [ s:baseDarkest, s:red ] ]
let s:p.insert.warning = [ [ s:baseDarkest, s:orange ] ]

let s:p.visual.left = [ [ s:baseDarkest, s:green ], [ s:baseLightest, s:baseDark ], [ s:green, s:baseDarkest ] ]
let s:p.visual.right = [ [ s:baseDarkest, s:green ], [ s:baseLightest, s:baseDark ] , [ s:green, s:baseDarkest] ]
let s:p.visual.ok = [ [ s:baseDarkest, s:green ] ]
let s:p.visual.error = [ [ s:baseDarkest, s:red ] ]
let s:p.visual.warning = [ [ s:baseDarkest, s:orange ] ]

let s:p.tabline.left = [ [ s:baseDarkest, s:baseLight], [ s:baseLight, s:baseDarkest], [ s:baseDarkest, s:baseLight] ]
let s:p.tabline.tabsel = [ [ s:baseDarkest, s:baseLight] ]
let s:p.tabline.middle = [ [ s:baseLight, s:baseDarkest] ]
let s:p.tabline.right = [ [ s:baseLight, s:baseDarkest] ]

let g:lightline#colorscheme#material#palette = lightline#colorscheme#flatten(s:p)
