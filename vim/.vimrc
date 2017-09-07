let g:pathogen_disabled = []
call pathogen#infect()

" Syntax highlighting options
syntax on
set background=dark

colorscheme material
hi! Normal ctermbg=None
hi! LineNr ctermbg=None cterm=Bold
hi! CursorLineNr ctermfg=3
hi! SpecialKey ctermbg=None

" Plugin stems " {{{
function CommentLine()
	let l:firstChar = matchstr(getline('.'), '\S')
	let l:commentChars = split(&commentstring, '%s')

	if exists("l:commentChars[0]") && (l:firstChar != l:commentChars[0])
		exe 'normal' 'I' . l:commentChars[0]
		if exists("l:commentChars[1]")
			exe 'normal' 'A ' . l:commentChars[1]
		end
	end
endfunction
"}}}
" Custom Commands " {{{
command! MakeTags !ctags -R .

command! PdfLatex !pdflatex %
"Write to a file when you forgot to run vim as root
command! -bar SudoWrite w !sudo tee > /dev/null %
command! W SudoWrite | e!
" }}}
" Key Bindings " {{{
" Set leader to ','
let mapleader=","

map <up> <nop>
" Close buffer
nmap <down> :bp<bar>sp<bar>bn<bar>bd<CR>
" Next buffer
nmap <left> :bprev<CR>
" Previous buffer
nmap <right> :bnext<CR>

" Improved efficiency when typing commands
nnoremap ; :

" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Easy window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Templates for common programming languages
nmap <Leader>lc :-1read $HOME/.vim/templates/skeleton.c<CR>4ji<Tab>
" Comment lines
map <Leader>c :call CommentLine()<CR>

" }}}
" Behavior Settings " {{{
" Swap files in a separate directory
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp

" Default clipboard is system clipboard <3
"set clipboard=unnamedplus

" Faster redrawing
set lazyredraw
set ttyfast

" Don't behave as old vi
set nocompatible

" Backspace over everything in insert mode
set backspace=indent,eol,start

" Tab width options
set noexpandtab
set tabstop=4
set shiftwidth=4
set smartindent
set linespace=0

" Show all matching files when tab completing
set wildmenu
" Fuzzy search files recursively
set path+=**

" Show lightline on all active editors
set laststatus=2
set showtabline=2

" Remove lag when going back to normal mode by pressing <ESC>
set timeoutlen=1000
set ttimeoutlen=10
" Hide mode indicator from the command bar
set noshowmode
" Show line numbers
set number
" Relative numbering on by default
set rnu

" Search options
set hlsearch
set ignorecase
set smartcase
set incsearch

" Disable smart indentation when pasting text
set pastetoggle=<F2>

" View whitespace as meta-characters
set list
set listchars=tab:· 

" Auto-fold based on markers
set foldmethod=marker

" Auto-insert tabs as needed
filetype plugin indent on

" }}}
" Lightline configuration " {{{
let g:lightline = {
	\ 'colorscheme': 'material',
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': ''},
	\ 'tabline': {
	\	'left': [ [ 'bufferinfo' ],
	\			  ['bufferbefore'], ['buffercurrent'], ['bufferafter'] ],
	\	'right':[ [ 'absolutepath' ] ]
	\	},
	\ 'active': {
	\   'left': [ [ 'mode', 'paste'],
	\             [ 'fugitive', 'rwstat' ],
	\			  [ 'filename' ] ],
	\	'right': [ [ 'linterError', 'linterWarn', 'linterOK', 'whitespace', 'lineinfo' , 'percent' ],
	\			   [ 'file_info' ],
	\			   [ 'filetype' ] ]
	\	},
	\ 'component': {
	\	'file_info': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]'
	\	},
	\ 'component_expand': {
	\	'whitespace': 'WhitespaceCheck',
	\	'linterOK': 'LightlineLinterOK',
	\	'linterWarn': 'LightlineLinterWarn',
	\	'linterError': 'LightlineLinterError',
	\	'buffercurrent': 'lightline#buffer#buffercurrent2'
	\	},
	\ 'component_type': {
	\	'whitespace': 'warning',
	\	'linterOK': 'ok',
	\	'linterWarn': 'warning',
	\	'linterError': 'error'
	\	},
	\ 'component_function' : {
	\	'fugitive': 'LightLineFugitive',
	\	'rwstat': 'LightLineRWStat',
	\	'bufferbefore': 'lightline#buffer#bufferbefore',
	\	'bufferafter': 'lightline#buffer#bufferafter',
	\	'bufferinfo': 'lightline#buffer#bufferinfo'
	\	}
	\ }
" }}}
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
" Ale config " {{{
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_linters = {
	\ 'python': [ '' ],
	\ 'python3': [ '' ]
	\}
" }}}
" Syntax Checking " {{{
" Whitespace checker string
function! WhitespaceCheck()
	let wLine = lightline#whitespace#check_mixed_indent()
	if wLine > 0
		return 'mixed-indent [' . wLine . ']'
	endif
	return ''
endfunction
" Update the status bar when a file is written, to check for whitespaces
augroup autoCheck
	autocmd!
	autocmd BufWritePost * call lightline#update()
	autocmd User ALELint call lightline#update()
augroup END
" }}}
" Miscellaneous Autocommands " {{{
" Custom syntax highlighting for unusual file extensions
augroup autoFileRecognition
	autocmd!
	autocmd BufRead,BufNewFile *.xm set filetype=objc
	autocmd BufRead,BufNewFile *.nasm,*.asm set filetype=nasm
augroup END

" Automatically remove trailing space at the end of lines
autocmd BufWritePre * %s/\s\+$//e

augroup fileSpecificBindings
	autocmd!
	" Create a pdf of the current tex file with F5
	autocmd FileType tex map <buffer> <F5> :PdfLatex<CR>
	autocmd Filetype xdefaults map <F5> :call system('xrdb '.expand('%:p'))<CR>
	" Rebuild tags
	autocmd FileType {c,cpp,h,hpp,nasm,asm,inc,objc} map <F5> :MakeTags<CR>
augroup END
"}}}
