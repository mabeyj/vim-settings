" Initialize Pathogen
call pathogen#infect()
Helptags

" Basic Vim settings
" ==============================================================================

set incsearch number showcmd
set autoindent smartindent tabstop=4 shiftwidth=4 shiftround
set linebreak breakindent showbreak=····
set listchars=tab:▹—,trail:$,extends:>,precedes:<,eol:¬,nbsp:·
set backspace=indent,eol,start
set spell

" Don't fully indent the whole line when typing "#" at the beginning of a line.
set cinkeys-=0#
set indentkeys-=0#

set autoread                    " Reload changed, unmodified files automatically
set copyindent                  " Preserve vertical alignment when indenting
set scrolloff=3                 " Give more context when scrolling
set t_Co=256 t_ut=              " Fix colour issues when running in tmux

set formatoptions-=t            " Don't auto-wrap text everywhere
set formatoptions-=c            " Don't auto-insert comment leader when auto-wrapping
set formatoptions+=1            " Don't leave hanging 1-letter words
set formatoptions+=j            " Strip comment leader when joining lines
set formatoptions+=n            " Recognize lists when formatting

set textwidth=80
set colorcolumn=81              " Highlight long lines

set wildmode=list:longest,full  " Make commands/files autocomplete like Bash
set wildmenu                    " Show keyword list of tab autocomplete
set wildignore+=*.pyc,env*/**,build/**,node_modules,bower_components,bundle

set ruler
set statusline=%f\ %m%h%r%w%=\ B%n\ L%l/%L\ C%c%V\ 0x%B\ %P
set rulerformat=%40(%=%f\ %m%h%r%w\ B%n\ L%l/%L\ C%c%V\ 0x%B\ %P%)

set directory=~/tmp//,/tmp//
set backupdir=~/tmp//,/tmp//

syntax on

" Gvim options
" ==============================================================================

set guifont=Liberation\ Mono\ 10
set guioptions-=e
set guioptions-=r
set guioptions-=T
set guioptions-=L
set guioptions-=m

" Colour scheme
" ==============================================================================

let base16colorspace=256
set background=dark
color base16-default

" Filetype-specific settings
" ==============================================================================

filetype plugin on

autocmd FileType php set comments=sr:/*,mb:*,ex:*/,://
autocmd FileType go,javascript,php,python set formatoptions=croqn1

" SCSS is close enough to LESS, which doesn't have default syntax highlighting
autocmd BufNewFile,BufRead *.less set filetype=scss

" Mappings
" ==============================================================================

set pastetoggle=<Leader>p

nnoremap <Leader>z :sp ~/.vimrc<CR>
nnoremap <Leader>x :so %<CR>

nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <Leader>F :NERDTreeMirror<CR>
nnoremap <Leader>T :TagbarToggle<CR>

nnoremap <Leader>i :IndentGuidesToggle<CR>
nnoremap <Leader>g :GitGutterToggle<CR>

nnoremap <Leader>l :set list!<CR>
nnoremap <Leader><Leader> :set spell!<CR>

iabbrev #D <C-r>=strftime("%F %I:%M %p")<CR>
iabbrev #t <C-r>=strftime("%I:%M %p")<CR>

" Better unmatched bracket mappings
nnoremap [b [(
nnoremap ]b ])
nnoremap [B [{
nnoremap ]B ]}

nnoremap c[b c[(
nnoremap c]b c])
nnoremap c[B c[{
nnoremap c]B c]}

" Align on =
nnoremap <Leader>= :Tabular equals<CR>
vnoremap <Leader>= :Tabular equals<CR>

" Write with sudo
cnoremap w!! w !sudo tee % > /dev/null

" Plugin settings
" ==============================================================================

" delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_jump_expansion = 1

" Go
let g:go_fmt_command = "goimports"
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_build_constraints = 1

" Indent guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0
let g:indent_guides_space_guides=0

hi IndentGuidesOdd ctermbg=234
hi IndentGuidesEven ctermbg=233

" NERDTree
let NERDTreeMouseMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['\.pyc$', '^__pycache__$']

" Sparkup
let g:sparkupNextMapping='<C-B>'     " Prevent conflict with Vim's autocomplete
