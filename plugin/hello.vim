":nmap <C-V> :w<CR>:so %<CR>:Helloworld<CR>
function! Helloworld()
    call s:createWin()
    call s:insertLines()
    call s:MapSpecs()
    call s:KeyLoop()
endfunction    
com! -nargs=0 Helloworld call Helloworld()

fu! s:createWin()
	exe 'keepa' 'bo' '10new NewWorld'
    cal s:setupblank()
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
        let s:bufids = ids
        let s:bufnames = bufnames
		retu bufnames
	en
endf

fu! s:setupblank()
	setl noswf nonu nobl nowrap nolist nospell nocuc wfh
	setl fdc=0 fdl=99 tw=0 bt=nofile bh=unload
    setl nornu noudf cc=0
endf

fu! s:KeyLoop()
    let s:init = 1
	wh exists('s:init')
		redr
		let nr = getchar()
		let chr = !type(nr) ? nr2char(nr) : nr
        echo '=======>'.chr.'===='.nr
		if nr >=# 0x20
            " pass
		el
			exe 'norm '.chr
		en
	endw
endf

fu! s:closeKeyLoop()
    unl! s:init
endf

fu! s:MapSpecs()
    "<SID> 当前文件作用域的sid
    echo 'nn <buffer> <silent>' '<c-g>' ':<c-u>cal <SID>'.'close()'.'<cr>'
    " 关闭
    exe 'nn <buffer> <silent>' '<c-c>' ':<c-u>cal <SID>'.'close()'.'<cr>'
    " 选择当前的行
    exe 'nn <buffer> <silent>' '<cr>' ':<c-u>cal <SID>'.'getcline()'.'<cr>'
    " 下一行
    exe 'nn <buffer> <silent>' '<c-j>' ':<c-u>cal <SID>'.'goNext()'.'<cr>'
    " 上一行
    exe 'nn <buffer> <silent>' '<c-k>' ':<c-u>cal <SID>'.'goPre()'.'<cr>'
endf

fu! s:close()
    echo 'i am close'
    cal s:closeKeyLoop()
    " close buffer
    bw!
    " don not trigger autocmd, then change cursor to last win
    noa winc p
endf

fu! s:getcline()
    cal s:closeKeyLoop()
    echo 'crt-->'.line('.').' -->'.s:bufnames[line('.') - 1]
    exe 'tabe '.s:bufnames[line('.') - 1]
endf

fu! s:goNext()
	exe 'keepj norm! j' 
endf

fu! s:goPre()
	exe 'keepj norm! k' 
endf

