function! s:CursorPosition()
	return [line('.'), col('.')]
endfunction

function! s:CursorChar()
	return getline('.')[col('.') - 1]
endfunction

" side: 0 for start, non-zero for end
function! s:BlockPosition(side)
	let old = s:CursorPosition()
	
	if (a:side != 0)
		normal ])
	else
		normal [(
	endif 

	let pos = s:CursorPosition()
	call cursor(old)

	return pos
endfunction

function! BreakLongArgs()
	" TODO: Doesn't break line on last argument
	" TODO: Option to break line after every argument
	" TODO: Handle multiple lines of arguments
	let start = s:BlockPosition(0)

	let percent_chars = ['(', '[', '{']
	let quote_chars = ['"', "'"]

	let last_arg = []

	normal [(

	while s:BlockPosition(0) == start && s:CursorPosition() != s:BlockPosition(1)
		let char = s:CursorChar()
		let pos = s:CursorPosition()

		if pos != start && index(percent_chars, char) != -1
			normal %
		elseif index(quote_chars, char) != -1
			" Find end of string, ignoring escaped quote characters
			execute 'normal /\\\@<!' . char . "\<CR>"
		elseif char == ','
			if last_arg != [] && pos[1] >= &textwidth
				" This argument causes the line to be long
				call cursor(last_arg)
				
				" start/stopinsert doesn't seem to work
				execute "normal a\<CR>\<Esc>"

				" Reset last argument position, since we just started a new line
				unlet last_arg
				let last_arg = []
			else
				unlet last_arg
				let last_arg = pos
			endif
		endif

		normal e
	endwhile
endfunction

nnoremap <Leader>s :call BreakLongArgs()<CR>
