" Various code formatting shortcuts.
"
" In all examples, the left side shows the original text and the right size
" shows the result.  The "^" in the left side is the position of the curson on
" the line above.


" Change single-line parenthesized group into multiple, indented lines.  The
" closing parenthesis is on the last line of the inner content.
"
" Examples
" ------------------------------------------------------------------------------
" a(<expr>)    =>  a(
"      ^               <expr>)
" a(<expr>).b  =>  a(
"      ^               <expr>).b
" a(<expr>     =>  a(
"      ^               <expr>
" ------------------------------------------------------------------------------
function! <SID>FormatMultilineEndSame()
	execute "normal [(a\<CR>\<C-t>\<Esc>])"

	if CursorChar() != ')'
		normal $
	endif
endfunction

autocmd FileType python nnoremap <Leader>m :call <SID>FormatMultilineEndSame()<CR>

" Change a single-line parenthesized group into multiple, indented lines.  The
" closing parenthesis is on its own line.
"
" Examples
" ------------------------------------------------------------------------------
" a(<expr>)    =>  a(
"      ^               <expr>
"                  )
" a(<expr>).b  =>  a(
"      ^               <expr>
"                  ).b
" a(<expr>     =>  a(
"      ^               <expr>
" ------------------------------------------------------------------------------
function! <SID>FormatMultilineEndNewline()
	call <SID>FormatMultilineEndSame()

	if CursorChar() == ')'
		execute "normal i\<CR>\<C-d>\<Esc>k$"
	endif
endfunction

autocmd FileType php,javascript,cpp nnoremap <Leader>m :call <SID>FormatMultilineEndNewline()<CR>

" Move chained function call to new line.
"
" Examples
" ------------------------------------------------------------------------------
" something.two().three(<expr>)  =>  something.two()
"                    ^                   .three(<expr>)
" something                      =>  something
"     .two().three(<expr>)               .two()
"               ^                        .three(<expr>)
" something.two().three(<expr>)  =>  something
"             ^                          .two().three(<expr>)
" something.two(<expr>           =>  something
"                  ^                     .two(<expr>
" something.two(                 =>  something
"     multi  ^                           .two(
"     line                                   multi
" )                                          line
"                                        )
" ------------------------------------------------------------------------------
function! <SID>FormatChainedCall()
	execute "normal F.i\<CR>\<Esc>^"

	" Compare character above to see if we need to indent or not
	normal k
	let prev_char = CursorChar()
	normal j

	if prev_char != '.'
		normal f(V%>
	endif

	normal f(%

	if CursorChar() != ')'
		normal $
	endif
endfunction

nnoremap <Leader>c :call <SID>FormatChainedCall()<CR>

" Vertically align text with the opening parenthesis, using spaces.
"
" Supports visual mode to align multiple lines.
"
" TODO: Doesn't handle blank lines very well
" TODO: Should match indentation of beginning line
"
" Examples
" ------------------------------------------------------------------------------
" something(multi     =>  something(multi
" line)                             line)
"   ^
" something(multi     =>  something(multi
"              line)                line)
"               ^
" something(multi     =>  something(multi
" line                              line
"  ^
" something(multi     =>  something(multi
" line).outside                     line).outside
"            ^ 
" something(a, (multi  =>  something(a, (multi
" line), b).outside                  line), b).outside
"        ^
" something(a, (multi  =>  something(a, (multi
" line), b).outside                      line), b).outside
"   ^
" something(a, (multi  =>  something(a, (multi
" line), b).outside                      line), b).outside
"              ^
" ------------------------------------------------------------------------------
function! <SID>FormatVerticalAlign() range
	normal [(

	if CursorChar() != '('
		" Not inside a group -- try beginning of line
		normal ^[(
	endif

	if CursorChar() == '('
		let dest_column = virtcol('.') + 1
		let done = 0

		execute ':' a:firstline

		while !done
			while virtcol('.') > dest_column
				normal hx
			endwhile

			while virtcol('.') < dest_column
				execute "normal i \<Esc>^"
			endwhile

			if line('.') != a:lastline
				normal j^
			else
				let done = 1
			endif
		endwhile

		normal ])

		if CursorChar() != ')'
			normal $
		endif
	else
		echom "Not in a parenthesized group"
	endif

	execute ":" a:lastline
endfunction

nnoremap <Leader>v :call <SID>FormatVerticalAlign()<CR>
vnoremap <Leader>v :call <SID>FormatVerticalAlign()<CR>

" Wrap a condition after a conditional or loop declaration.  Intended for Python
" code, but may have other uses.
"
" Examples
" ------------------------------------------------------------------------------
" if something == 5:  =>  if (something == 5):
"            ^
" if a == b           =>  if (a == b
"       ^
" ------------------------------------------------------------------------------
function! <SID>FormatWrapCondition()
	execute "normal ^wi(\<Esc>$"

	if CursorChar() == ':'
		execute "normal ha)\<Esc>"
	endif
endfunction

nnoremap <Leader>w :call <SID>FormatWrapCondition()<CR>
