"let g:pathogen_disabled = [ 'YouCompleteMe', 'Syntastic' ]
let g:ycm_server_python_interpreter = '/usr/bin/python2'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
call pathogen#infect()

" Syntax highlighting options
syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set background=dark

colorscheme material
hi! Normal ctermbg=None
hi! LineNr ctermbg=None cterm=Bold
hi! CursorLineNr ctermfg=3
hi! SpecialKey ctermbg=None


" ++++++++ Custom Commands ++++++++
command! MakeTags !ctags -R .
command! PdfLatex !pdflatex %



" ++++++++ Key Mappings ++++++++
" Set leader to ','
let mapleader=","
map Q <nop>
map <up> <nop>
map <F1> <nop>
" Close buffer
map <down> :bp<bar>sp<bar>bn<bar>bd<CR>
" Next buffer
map <left> :bprev<CR>
" Previous buffer
map <right> :bnext<CR>

" Improved efficiency when typing commands
nnoremap ; :

" Faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Relative-Absolute numbering toggle
nmap <C-n> :set rnu!<CR>
" Nicer, lighter syntastic configuration
map <Leader>e :Errors<CR>
map <Leader>u :lclose<CR>
" Call syntastic on command
map <Leader>c :call SyntasticUpdate()<CR>
" Templates for common programming languages
map <Leader>lc :-1read $HOME/.vim/templates/default.c<CR>4ji<Tab>
map <Leader>lC :-1read $HOME/.vim/templates/default.cpp<CR>6ji<Tab>



" ++++++++ Behavior Settings ++++++++
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
set softtabstop=4
set shiftwidth=4
set smartindent
set linespace=0

" File options
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
set listchars=tab:⸱ 

" ++++++++ Lightline configuration ++++++++
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
	\	'right': [ [ 'syntastic', 'whitespace', 'lineinfo' , 'percent' ],
	\			   [ 'file_info' ],
	\			   [ 'filetype' ] ]
	\	},
	\ 'component': {
	\	'file_info': '%{&fenc!=#""?&fenc:&enc}[%{&ff}]'
	\	},
	\ 'component_expand': {
	\	'whitespace': 'WhitespaceCheck',
	\	'buffercurrent': 'lightline#buffer#buffercurrent2',
	\	'syntastic': 'SyntasticStatuslineFlag'
	\	},
	\ 'component_type': {
	\	'whitespace': 'warning',
	\	'syntastic': 'error'
	\	},
	\ 'component_function' : {
	\	'fugitive': 'LightLineFugitive',
	\	'rwstat': 'LightLineRWStat',
	\	'bufferbefore': 'lightline#buffer#bufferbefore',
	\	'bufferafter': 'lightline#buffer#bufferafter',
	\	'bufferinfo': 'lightline#buffer#bufferinfo'
	\	}
	\ }



" ++++++++ Lightline Functions ++++++++
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
	let isReadonly = &ft !~? 'help' && &readonly ? "": ""
	let isModified = &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '[+]' : &modifiable ? '' : '[-]'
	return isModified . isReadonly
endfunction



" ++++++++ Syntax Checking ++++++++
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }

function! SyntasticUpdate()
	SyntasticCheck
	call lightline#update()
endfunction
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
	"if exists("SyntasticCheck")
		"autocmd BufWritePost *.{c,h,cpp,hpp,nasm,asm,inc,sh} call SyntasticUpdate()
	"endif
augroup END


" ++++++++ Miscellaneous Autocommands ++++++++
" Custom syntax highlighting for unusual file extensions
augroup autoFileRecognition
	autocmd!
	autocmd BufRead,BufNewFile *.xm set filetype=objc
	autocmd BufRead,BufNewFile *.nasm,*.asm set filetype=nasm

	 " I shouldn't have to do this, really, but apparently
	 " vim thinks he is smarter than me and sets tabstop to 8
	 " for python scripts
	autocmd FileType python setlocal tabstop=4
	autocmd FileType python setlocal noexpandtab
augroup END

" Automatically remove trailing space at the end of lines
autocmd BufWritePre * %s/\s\+$//e

augroup fileSpecificBindings
	autocmd!
	" Create a pdf of the current tex file with F5
	autocmd FileType tex map <buffer> <F5> :PdfLatex<CR>
	" Rebuild tags
	autocmd FileType {c,cpp,h,hpp,nasm,asm,inc,objc} map <F5> :MakeTags<CR>
augroup END
