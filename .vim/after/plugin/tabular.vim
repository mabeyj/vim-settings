if !exists(':Tabularize')
	finish
endif

" Avoid aligning on "=>" inside keys or values.  This tries to match the
" separator as the "<key> =>", but ignores the key as part of the match.  Works
" if the key is a single- or double-quoted string.
AddTabularPattern! php_key /^\s*\('\(\\'\|[^']\)*'\|"\(\\"\|[^"]\)*"\|.*\)\s*\zs=>/

" Align on first "="
AddTabularPattern! equals /^[^=]*\zs=/

" Align JavaScript key/value pairs, but don't line up every ":" separator (i.e.,
" ":" inside a key or value).
"
" Pipeline works as follows: reduce whitespace so that each line is simply
" "<key>: <value>", then align on space directly after the colon.
AddTabularPipeline! javascript_key /:/
	\ map(a:lines, 'substitute(v:val, ''^\s*\(''''\(\\''''\|[^\'''']\)*''''\|"\(\\"\|[^"]\)*"\|\w\+\)\zs\s*:\s*'', ": ", "")')
	\ | tabular#TabularizeStrings(a:lines, '^\s*\(''\(\\''\|[^\'']\)*''\|"\(\\"\|[^"]\)*"\|\w\+\):\zs ', 'l0')
