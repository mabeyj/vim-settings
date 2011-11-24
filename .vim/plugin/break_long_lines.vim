" Returns the character under the cursor.
function! s:CursorChar()
	return getline('.')[col('.') - 1]
endfunction

" Returns the current cursor position as List [line, column].
function! s:CursorPosition()
	return [line('.'), col('.')]
endfunction

" Returns the position of one end of the current block as List [line, column].
" side: 0 to return start, non-0 to return end
function! s:BlockPosition(side)
	let old = s:CursorPosition()

	" [( or ]) inside a double-quoted string doesn't work for some reason
	if (a:side != 0)
		normal vab
	else
		normal vabo
	endif 

	let pos = s:CursorPosition()
	execute "normal \<Esc>"

	call cursor(old)

	return pos
endfunction

" Returns the start position of the current block as List [line, column].
function! s:BlockStartPosition()
	return s:BlockPosition(0)
endfunction

" Returns the end position of the current block as List [line, column].
function! s:BlockEndPosition()
	return s:BlockPosition(1)
endfunction

" Returns whether or not the cursor is past the textwidth limit.
function! s:IsCursorPastTextWidth()
	return virtcol('.') >= &textwidth
endfunction

" Appends a new line at current cursor position.
function! s:AppendNewLine()
	" start/stopinsert doesn't seem to work
	execute "normal a\<CR>\<Esc>"
endfunction

" Returns whether or not the cursor is inside the identified block.
" start: Start position of block
function! s:IsCursorInsideBlock(start)
	let old = s:CursorPosition()

	call cursor(a:start)
	let end = s:BlockEndPosition()
	call cursor(old)

	let between_lines = old[0] > a:start[0] && old[0] < end[0]
	let on_or_after_start = old[0] == a:start[0] && old[1] >= a:start[1]
	let on_or_before_end = old[0] == end[0] && old[1] <= end[1]

	return between_lines || on_or_after_start || on_or_before_end
endfunction

" Breaks comma-separated arguments according to some criteria.
" every_arg: 0 to break before every argument that causes a long line, non-0 to
" break after every argument
function! BreakArgs(every_arg)
	" Start of block will never change, but the end will.  So, use the start as
	" an anchor point
	let start = s:BlockStartPosition()

	let percent_chars = ['(', '[', '{']
	let quote_chars = ['"', "'"]
	let arg_end_char = ','

	let last_arg = []
	let indented = 0

	" Put everything all on one line
	if (start[0] != s:BlockEndPosition()[0])
		" TODO: This removes new lines that were part of arguments (e.g.,
		" anonymous functions) -- instead, traverse through arguments and join
		" at each comma
		normal vabJ
		call cursor(start)

		" Join might put a space right after the "(" -- remove it
		normal l

		if s:CursorChar() == ' '
			normal x
		endif
	endif

	call cursor(start)

	while s:IsCursorInsideBlock(start)
		let char = s:CursorChar()
		let pos = s:CursorPosition()

		if pos != start && index(percent_chars, char) != -1
			normal %
		elseif index(quote_chars, char) != -1
			" Find end of string, ignoring escaped quote characters
			execute "normal /\\\\\\@<!\"\<CR>"
		elseif char == arg_end_char
			if last_arg != [] && (a:every_arg || s:IsCursorPastTextWidth())
				" This argument causes the line to be too long
				call cursor(last_arg)
				call s:AppendNewLine()

				" Indent on first break -- the indent is copied for following
				" breaks
				if !indented
					normal >>
					let indented = 1
				endif

				" Reset last argument position, since we just started a new line
				let last_arg = []
			else
				let last_arg = pos
			endif
		endif

		normal e
	endwhile

	" Handle final argument
	if last_arg != [] && (a:every_arg || s:IsCursorPastTextWidth())
		call cursor(last_arg)
		call s:AppendNewLine()
	endif
endfunction

nnoremap <Leader>s :call BreakArgs(0)<CR>
nnoremap <Leader>S :call BreakArgs(1)<CR>
