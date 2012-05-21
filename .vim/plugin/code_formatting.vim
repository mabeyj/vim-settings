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

" Vertically align to the given column all lines in the given range (inclusive).
"
" TODO: Doesn't handle blank lines very well
" TODO: Should match indentation of beginning line
function! s:VerticalAlign(column, first_line, last_line)
	let done = 0

	execute ':' a:first_line

	while !done
		while virtcol('.') > a:column
			normal hx
		endwhile

		while virtcol('.') < a:column
			execute "normal i \<Esc>^"
		endwhile

		if line('.') != a:last_line
			normal j^
		else
			let done = 1
		endif
	endwhile
endfunction

" Vertically align text with the opening parenthesis, using spaces.
"
" Supports visual mode to align multiple lines.
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
		call s:VerticalAlign(virtcol('.') + 1, a:firstline, a:lastline)

		normal ])

		if CursorChar() != ')'
			normal $
		endif
	else
		echom "Not in a parenthesized group"
	endif
endfunction

nnoremap <Leader>v :call <SID>FormatVerticalAlign()<CR>
vnoremap <Leader>v :call <SID>FormatVerticalAlign()<CR>

" Vertically align text with "--".
"
" This is mainly for Python documentation of the form:
"
" some_variable_name -- short description
"
" Examples
" ------------------------------------------------------------------------------
" variable -- multi  =>  variable -- multi
" line                               line
"   ^
" ------------------------------------------------------------------------------
function! <SID>FormatVerticalAlignDoubleDash() range
	let matched = search("^\\s*[a-zA-Z0-9()_-]\\+ -- ", "beW")

	if matched > 0
		call s:VerticalAlign(virtcol('.') + 1, a:firstline, a:lastline)
		execute ':' a:lastline
		normal $
	else
		echom "Not found"
	endif
endfunction

nnoremap <Leader>V :call <SID>FormatVerticalAlignDoubleDash()<CR>
vnoremap <Leader>V :call <SID>FormatVerticalAlignDoubleDash()<CR>

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

" Change a single-line Python docstring into a multline docstring.
"
" Examples
" ------------------------------------------------------------------------------
" """Doc"""  =>  """
"    ^           Doc
"                """
" """Doc     =>  """
"    ^           Doc
" Doc"""     =>  Doc
"   ^            """
" ------------------------------------------------------------------------------
function! <SID>FormatMultilineDocstring()
	let line = getline('.')
	let start_match = match(line, "^[\s\t]*\\(\"\"\"\\|'''\\)")
	let end_match = match(line, "\\(\"\"\"\\|'''\\)$")

	if start_match != -1
		execute "normal ^wi\<CR>\<Esc>"
	endif

	if end_match != -1
		execute "normal $bi\<CR>\<Esc>k"
	endif

	if start_match != -1 || end_match != -1
		normal $
	endif
endfunction

nnoremap <Leader>d :call <SID>FormatMultilineDocstring()<CR>
