":nmap <C-V> :w<CR>:so %<CR>:Helloworld<CR>
function! Helloworld()
     call s:createWin()
     call s:insertLines()
     "call s:Render([], '')
endfunction    
com! -nargs=0 Helloworld call Helloworld()

fu! s:createWin()
	exe 'keepa' 'bo' '10new NewWorld'
endf

fu! s:insertLines()
	cal setline(1, s:getBufferNames())
endf

fu! s:getBufferNames()
	let ids = filter(range(1, bufnr('$')), 'empty(getbufvar(v:val, "&bt"))'
		\ .' && getbufvar(v:val, "&bl")')
		let bufnames = []
		for id in ids
			let bname = bufname(id)
			cal add(bufnames, bname)
		endfo
		retu bufnames
	en
endf

