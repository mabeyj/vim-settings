if !exists(':Tabularize')
	finish
endif

" Avoid aligning on "=>" inside keys or values.  This tries to match the
" separator as the "<key> =>", but ignores the key as part of the match.  Works
" if the key is a single- or double-quoted string.
AddTabularPattern! php_key /^\s*\('\(\\'\|[^']\)*'\|"\(\\"\|[^"]\)*"\|.*\)\s*\zs=>/

" Align JavaScript values, but don't line up every ":" separator (i.e., ":" is
" placed directly after key)
"
" Pipeline works as follows: reduce whitespace so that each line is simply
" "<key>: <value>", then align on space directly after the cursor.
AddTabularPipeline! javascript_key /:/
	\ map(a:lines, 'substitute(v:val, ''^\s*\(''''\(\\''''\|[^\'''']\)*''''\|"\(\\"\|[^"]\)*"\|\S\+\)\zs\s*:\s*'', ": ", "")')
	\ | tabular#TabularizeStrings(a:lines, '^\s*\(''\(\\''\|[^\'']\)*''\|"\(\\"\|[^"]\)*"\|[^:]\+\):\zs ', 'l0')
