call plug#begin('~/.config/nvim/bundle')
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
call plug#end()

source ~/.config/nvim/pluginStems.vim
source ~/.config/nvim/lightline.vim
source ~/.config/nvim/ale.vim
source ~/.config/nvim/colors.vim

hi ColorColumn ctermbg=gray
call matchadd('ColorColumn', '\%81v', 100)

command! MakeTags !ctags -R .

command! PdfLatex !pdflatex -output-directory /tmp %
"Write to a file when you forgot to run vim as root
command! -bar SudoWrite w !sudo tee > /dev/null %
command! W SudoWrite | e!

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
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Easy window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

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
set relativenumber

" Disable smart indentation when pasting text
set pastetoggle=<F2>

" View whitespace as meta-characters
set list
set listchars=tab:·\ 

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
augroup END

" Automatically remove trailing space at the end of lines
"autocmd BufWritePre * %s/\s\+$//e
augroup fileTypeSyntaxOptions
	autocmd!
	autocmd FileType ruby set ts=2 sts=2 sw=2 expandtab
augroup END

augroup fileSpecificBindings
	autocmd!
	" Create a pdf of the current tex file with F5
	autocmd FileType tex map <F5> :PdfLatex<CR>
	"autocmd BufWritePost *.tex :PdfLatex
	autocmd Filetype xdefaults map <F5> :call system('xrdb '.expand('%:p'))<CR>
	" Rebuild tags
	autocmd FileType {c,cpp,h,hpp,nasm,asm,inc,objc} map <F5> :MakeTags<CR>
augroup END
