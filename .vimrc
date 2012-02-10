" Initialize Pathogen
call pathogen#infect()
Helptags

" Basic Vim settings {{{

set incsearch mouse=a number showcmd
set autoindent tabstop=4 shiftwidth=4
set listchars=tab:>\ ,trail:$
set scrolloff=3                 " Give more context when scrolling
set wildmode=list:longest,full  " Make commands/files autocomplete like Bash
set wildmenu                    " Show keyword list of tab autocomplete

set textwidth=80
set colorcolumn=81              " Highlight long lines

set statusline=%f\ %m%h%r%w\ %y\ %{fugitive#statusline()}%=\ B%3n\ ·\ L%5l/%5L\ ·\ C%7(%c%V%)\ ·\ %4(0x%B%)\ ·\ %P
set rulerformat=%45(%=B%3n\ ·\ L%5l/%5L\ ·\ C%7(%c%V%)\ ·\ %4(0x%B%)\ ·\ %P%)

" }}}
" Gvim options {{{

set guifont=Code2_smooth\ 12
set guioptions-=e
set guioptions-=r
set guioptions-=T
set guioptions-=L

" }}}
" Colour scheme {{{

set background=dark
color sunburst
hi ColorColumn ctermbg=234

" }}}
" Filetype-specific settings {{{

filetype plugin on

" Trim trailing spaces for certain filetypes
function! <SID>TrimTrailingWhitespace()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfunction

autocmd FileType javascript,php,python,sh,css,html autocmd BufWritePre <buffer> :call <SID>TrimTrailingWhitespace()

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType php set comments=sr:/*,mb:*,ex:*/,://
autocmd FileType php,javascript set fo=croqn1

" For some reason, tags are wrapped
autocmd FileType html,xml set fo=roqn1

" }}}
" Mappings {{{

set pastetoggle=<Leader>p

nnoremap <Leader>z :sp ~/.vimrc<CR>
nnoremap <Leader>x :so %<CR>

nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <Leader>F :NERDTreeMirror<CR>
nnoremap <Leader>d :TagbarToggle<CR>

nnoremap <Leader>g :IndentGuidesToggle<CR>

nnoremap <Leader><Leader> :set spell!<CR>

" Better unmatched bracket mappings
nnoremap [b [(
nnoremap ]b ])
nnoremap [B [{
nnoremap ]B ]}

nnoremap c[b c[(
nnoremap c]b c])
nnoremap c[B c[{
nnoremap c]B c]}

" Open documentation for current word -- for some reason, the screen gets
" cleared and needs to be redrawn
autocmd FileType php nnoremap K :silent !google-chrome http://php.net/<cword><CR>:redraw!<CR>

" Align key/value pairs
autocmd FileType php nnoremap <Leader>k :Tabular php_key<CR>
autocmd FileType php vnoremap <Leader>k :Tabular php_key<CR>

autocmd FileType javascript nnoremap <Leader>k :Tabular javascript_key<CR>
autocmd FileType javascript vnoremap <Leader>k :Tabular javascript_key<CR>

" Align doc comment @param descriptions
autocmd FileType php,javascript nnoremap <Leader>j :Tabular multiple_spaces<CR>
autocmd FileType php,javascript vnoremap <Leader>j :Tabular multiple_spaces<CR>

" Align on =
nnoremap <Leader>= :Tabular /=<CR>
vnoremap <Leader>= :Tabular /=<CR>

" Change single-line parenthesized group into multiple, indented lines
"
" (<expr>)  =>  (
"                   <expr>
"               )
"
" TODO: Also split up arguments on multiple lines
nnoremap <Leader>i [(a<CR><C-t><Esc>])i<CR><C-d><Esc>k$

" Move chained function call to new line ("c" indents, "C" does not)
"
" .one().two().three(<expr>)  =>  <Leader>c  =>  .one().two()
"    Cursor here ^                                   .three(<expr>)
"
" .one()                      =>  <Leader>C  =>  .one()
"     .two().three(<expr>)                           .two()
"    Cursor here ^                                   .three(<expr>)
nnoremap <Leader>c F.i<CR><Esc>%V%>%
nnoremap <Leader>C F.i<CR><Esc>%

" Write with sudo
cnoremap w!! w !sudo tee % > /dev/null

" Hit jk at same time to trigger Esc
call arpeggio#load()
Arpeggio noremap jk <Esc>
Arpeggio inoremap jk <Esc>
Arpeggio cnoremap jk <C-c>

" }}}
" Plugin settings {{{

" Indent guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0
let g:indent_guides_space_guides=0

hi IndentGuidesOdd ctermbg=234
hi IndentGuidesEven ctermbg=233

" Tagbar
let g:tagbar_autofocus=1
let g:tagbar_autoclose=1

" NERDTree
let NERDTreeMouseMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['\.pyc$', '^__pycache__$']

" Sparkup
let g:sparkupNextMapping='<C-B>'     " Prevent conflict with Vim's autocomplete

" UltiSnips
let g:UltiSnipsSnippetDirectories=["snippets"]

" }}}
