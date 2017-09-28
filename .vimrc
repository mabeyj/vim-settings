execute pathogen#infect()
Helptags

set encoding=utf-8  " For gvim on Windows.

" Basic Vim settings
" ==============================================================================

" Hybrid line numbers: show exact number for current line and relative line
" numbers elsewhere.
set number relativenumber

set incsearch showcmd
set autoindent smartindent tabstop=4 shiftwidth=4 shiftround
set showbreak=↪\ \  linebreak breakindent
set listchars=tab:⇨\ ,trail:$,extends:>,precedes:<,eol:¬,nbsp:·
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

set wildmode=list:longest,full  " Make commands/files autocomplete like Bash
set wildmenu                    " Show keyword list of tab autocomplete
set wildignore+=*.pyc,env*/**,build/**,node_modules,bower_components,bundle

set laststatus=2                " Always show status line
set statusline=%f\ %m%h%r%w%q%=\ C%c%V[%02B]\ L%l/%L[%P]

set directory=~/tmp//,/tmp//
set backupdir=~/tmp//,/tmp//

syntax on

" Gvim options
" ==============================================================================

set guifont=Fantasque\ Sans\ Mono:h14
set guioptions-=e
set guioptions-=r
set guioptions-=T
set guioptions-=L
set guioptions-=m

" Colour scheme
" ==============================================================================

let base16colorspace=256
set background=dark
color base16-default-dark

" Hide ~ lines
highlight EndOfBuffer ctermfg=bg guifg=bg

" Filetype-specific settings
" ==============================================================================

filetype plugin on

" Mappings
" ==============================================================================

set pastetoggle=<Leader>p

nnoremap <Leader>z :sp ~/.vimrc<CR>
nnoremap <Leader>x :so %<CR>

nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <Leader>F :NERDTreeMirror<CR>

nnoremap <Leader>l :set list!<CR>
nnoremap <Leader>s :set spell!<CR>

iabbrev #D <C-r>=strftime("%F %I:%M %p")<CR>
iabbrev #t <C-r>=strftime("%I:%M %p")<CR>

" Write with sudo
cnoremap w!! w !sudo tee % > /dev/null

" Plugin settings
" ==============================================================================

" delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_jump_expansion = 1

" Go
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
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

highlight IndentGuidesOdd ctermbg=234
highlight IndentGuidesEven ctermbg=233

" NERDTree
let NERDTreeMouseMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['\.pyc$', '^__pycache__$']

" UltiSnips
let g:UltiSnipsNoPythonWarning = 1
