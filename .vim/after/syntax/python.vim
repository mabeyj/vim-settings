syntax region pythonDocstring
	\ contains=pythonDocstringFirstLine,pythonDocstringPropSection
	\ start=+^\s*[uU]\?\z('''\|"""\)+
	\ end="\z1"

" FIXME: You can "nest" docstrings and it will still highlight the first line
" of the inner docstring
syntax region pythonDocstringFirstLine contained
	\ start=+\z('''\|"""\)\zs+
	\ end="^$"
	\ end="\ze\z1"

" Highlight PEP257-style property, argument, attribute, and method
" documentation.
"
" Example
" ------------------------------------------------------------------------------
" Instance attributes:
" some_var -- description
"             long description
"
" Methods:
" do_something() -- description
" ------------------------------------------------------------------------------

" Transparent region for matching a section of a docstring that contains
" property descriptions.
"
" start: leading whitespace is \z1, match words up to ":", then match the first
"        property line (e.g., "name -- description" or 
"        "method() -- description")
" skip: properties lines and any lines after that have more indentation than \z1
"       (i.e., continuation of property description) OR an empty line
" end: any unskipped line or just before ending docstring
syntax region pythonDocstringPropSection contained transparent
	\ contains=pythonDocstringProp,pythonDocstringHeading
	\ start="^\z(\s*\)\(\w\|\s\)\+:\n\s*\w\+\(()\)\? -- \w"
	\ skip="^\(\z1\(\w\+\(()\)\? -- \|\s\+\)\|$\)"
	\ end="^"
	\ end=+'''\|"""+he=e-3

syntax match pythonDocstringProp contained 
	\ "^\s*\zs\w\+\(()\)\?\ze -- "

syntax match pythonDocstringHeading contained
	\ "^\s*\zs\(\w\|\s\)\+:"

" Fix cases where highlighting for docstring properties does not update
syntax sync linebreaks=1

highlight link pythonDocstring Comment
highlight link pythonDocstringFirstLine CommentSummary
highlight link pythonDocstringProp CommentProp
highlight link pythonDocstringHeading CommentHeading
highlight link CommentSummary Comment
highlight link CommentProp Comment
highlight link CommentHeading Comment
