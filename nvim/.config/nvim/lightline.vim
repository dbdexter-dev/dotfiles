let g:lightline = {
	\ 'colorscheme': 'Tomorrow_Night_Bright',
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': ''},
	\ 'tabline': {
	\	'left': [ [ 'buffers' ] ],
	\	'right':[ [ 'absolutepath' ] ]
	\	},
	\ 'active': {
	\   'left': [ [ 'mode', 'paste'],
	\             [ 'fugitive', 'rwstat' ],
	\			  [ 'filename' ] ],
	\	'right': [ [ 'linterError', 'linterWarn', 'linterOK', 'lineinfo' , 'percent' ],
	\			   [ 'file_info' ],
	\			   [ 'filetype' ] ]
	\	},
	\ 'component': {
	\	'file_info': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]'
	\	},
	\ 'component_expand': {
	\	'linterOK': 'LightlineLinterOK',
	\	'linterWarn': 'LightlineLinterWarn',
	\	'linterError': 'LightlineLinterError',
	\	'buffers': 'lightline#bufferline#buffers'
	\	},
	\ 'component_type': {
	\	'linterOK': 'ok',
	\	'linterWarn': 'warning',
	\	'linterError': 'error',
	\	'buffers': 'tabsel'
	\	},
	\ 'component_function' : {
	\	'fugitive': 'LightLineFugitive',
	\	'rwstat': 'LightLineRWStat'
	\	}
	\ }
" Lightline Functions " {{{
" Fugitive-related status string
function! LightLineFugitive()
	if exists("*fugitive#head")
		let branch = fugitive#head()
		return branch !=# '' ? ' '.branch : ''
	endif
	return ''
endfunction

" Read-Write status string
function! LightLineRWStat()
	let isReadonly = &ft !~? 'help' && &readonly ? "": ""
	let isModified = &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '[+]' : &modifiable ? '' : '[-]'
	return isModified . isReadonly
endfunction

" Get linter status
function! LightlineLinterError() abort
	let l:count = ale#statusline#Count(bufnr(''))
	let l:all_errors = l:count.error + l:count.style_error
	return l:count.total == 0 ? '' : printf('E: %d', l:all_errors)
endfunction

function! LightlineLinterWarn() abort
	let l:count = ale#statusline#Count(bufnr(''))
	let l:all_errors = l:count.error + l:count.style_error
	let l:all_non_errors = l:count.total - l:all_errors
	return l:count.total == 0 ? '' : printf('W: %d', l:all_non_errors)
endfunction

function! LightlineLinterOK() abort
	let l:count = ale#statusline#Count(bufnr(''))
	return l:count.total == 0 ? 'OK' : ''
endfunction
" }}}
