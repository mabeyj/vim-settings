" Trim trailing whitespace for certain file types

function! <SID>TrimTrailingWhitespace()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfunction

autocmd FileType javascript,php,python,sh,css,scss,html,xml,markdown autocmd BufWritePre <buffer> :call <SID>TrimTrailingWhitespace()
