function! IsOnBattery()
	return readfile("/sys/class/power_supply/AC/online") == ['0']
endfunction

if IsOnBattery()
	let g:ale_lint_on_text_changed = 'never'
	let g:ale_linters = {
	\	'python': [ '' ],
	\	'python3': [ '' ]
	\ }
endif
augroup UpdateLightlineOnLint
	autocmd!
	autocmd User ALELint call lightline#update()
augroup END

let g:ale_fixers = {
      \ 'ruby' : [ 'rubocop' ]
      \ }
