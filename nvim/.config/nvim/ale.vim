function! IsOnBattery()
	return readfile("/sys/class/power_supply/AC/online") == ['0']
endfunction

let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {
\	'python': [ '' ],
\	'python3': [ '' ]
\ }

augroup UpdateLightlineOnLint
	autocmd!
	autocmd User ALELint call lightline#update()
augroup END

let g:ale_fixers = {
      \ 'ruby' : [ 'rubocop' ]
      \ }
