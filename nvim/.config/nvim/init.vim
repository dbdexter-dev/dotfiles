call plug#begin('~/.config/nvim/bundle')
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

source ~/.config/nvim/pluginStems.vim
source ~/.config/nvim/lightline.vim
source ~/.config/nvim/ale.vim
source ~/.config/nvim/colors.vim

command! MakeTags !ctags -R .

command! PdfLatex !pdflatex -output-directory /tmp %
"Write to a file when you forgot to run vim as root
command! -bar SudoWrite w !sudo tee > /dev/null %
command! W SudoWrite | e!

" Disable cursor shapeshifting
set guicursor=

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
vnoremap ; :

" Faster scrolling
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
vnoremap <C-e> 5<C-e>
vnoremap <C-y> 5<C-y>

" Easy window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Less-carpalsy completion
imap <C-o> <C-x><C-o>
inoremap <C-n> <C-p>
inoremap <C-p> <C-n>

" Because vim-vinegar isn't really needed
nmap - :e .<CR>

" Get out of insert mode when in a terminal
tmap <Leader><Esc> <C-\><C-n>

" Comment lines
map <Leader>c :call CommentLine()<CR>
" Remake ctags
nmap <Leader>t :MakeTags<CR><CR>

" Swap files in a separate directory
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp

" Tab width options
set noexpandtab
set tabstop=4
set shiftwidth=4
set smartindent

set showtabline=2

" Show all matching files when tab completing
set wildmenu
" Fuzzy search files recursively
set path+=**

" Hide mode indicator from the command bar
set noshowmode
" Show line numbers
set number
" Show relative numbers
set rnu

" Search through headers as well
set complete+=i
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Disable smart indentation when pasting text
set pastetoggle=<F2>

" View whitespace as meta-characters
set list
set listchars=tab:·\ " Don't fuck with this pls

" Auto-fold based on markers
set foldmethod=marker

set ignorecase
set smartcase


" Custom syntax highlighting for unusual file extensions
augroup autoFileRecognition
	autocmd!
	autocmd BufRead,BufNewFile *.xm set filetype=objc
	autocmd BufRead,BufNewFile *.Xdefaults set filetype=xdefaults
	autocmd BufRead,BufNewFile *.tex set tw=100
	autocmd BufRead,BufNewFile *.nasm,*.asm,*.inc set filetype=nasm
	autocmd BufRead,BufNewFile *.h set filetype=c
augroup END

" Automatically remove trailing space at the end of lines
autocmd BufWritePre * %s/\s\+$//e
augroup fileTypeSyntaxOptions
	autocmd!
	autocmd FileType ruby set ts=2 sts=2 sw=2 expandtab
	autocmd FileType c,markdown set tw=80 colorcolumn=+1,+2
augroup END

augroup fileSpecificBindings
	autocmd!
	" Create a pdf of the current tex file with F5
	autocmd FileType tex map <F5> :PdfLatex<CR>
	"autocmd BufWritePost *.tex :PdfLatex
	autocmd Filetype xdefaults map <F5> :call system('xrdb '.expand('%:p'))<CR>
	" Markdown to HTML
	" autocmd FileType markdown map <F5> :MarkdownHTML<CR>
	" Rebuild tags
	autocmd FileType {c,cpp,h,hpp,nasm,asm,inc,objc} map <F5> :MakeTags<CR>
augroup END

augroup formatting
	autocmd!
	autocmd VimResized * wincmd =
augroup END

" /comfy/ netrw project browser
"let g:netrw_winsize = 20
"let g:netrw_liststyle = 3
"let g:netrw_browse_split  = 4
"let g:netrw_altv = 1
"let g:netrw_banner = 0
