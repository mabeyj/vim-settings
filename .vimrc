" Plugins
" ==============================================================================

packadd! matchit

execute pathogen#infect()
Helptags

" Basic Vim settings
" ==============================================================================

" Update time: shorten for quicker GitGutter updates.
set updatetime=250

" Encoding: explicity set for gvim on Windows.
set encoding=utf-8

" Hybrid line numbers: show exact number for current line and relative line
" numbers elsewhere.
set number relativenumber

" Search: use incremental search and highlight all matches.
set incsearch hlsearch

set showcmd
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
set wildignore+=*.pyc,env*,build,bundle,bower_components,node_modules,vendor

set laststatus=2                " Always show status line
set statusline=%f\ %m%h%r%w%q
set statusline+=%#goStatuslineColor#%{go#statusline#Show()}%*
set statusline+=%=\ C%c%V[%02B]\ L%l/%L[%P]

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

" Change base16 spelling colour. Default also uses undercurl which isn't
" supported by mintty.
highlight SpellBad cterm=underline ctermfg=9 ctermbg=none
highlight SpellCap cterm=underline ctermfg=12 ctermbg=none

" Hide ~ lines
highlight EndOfBuffer ctermfg=bg guifg=bg

" Filetype-specific settings
" ==============================================================================

filetype indent plugin on

" Run Neoformat on save.
augroup neoformat
	autocmd!
	autocmd BufWritePre *.js,*.jsx,*.json,*.md,*.ts,*.tsx,*.yaml,*.yml Neoformat
augroup END

" Python
let g:python_recommended_style = 0

" YAML
autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 expandtab

" Mappings
" ==============================================================================

set pastetoggle=<Leader>p

" \\ to clear current search highlight.
nnoremap <Leader><Leader> :nohlsearch<CR>

" Clear search highlight when entering insert mode.
nnoremap A :nohlsearch<CR>A
nnoremap a :nohlsearch<CR>a
nnoremap I :nohlsearch<CR>I
nnoremap i :nohlsearch<CR>i
nnoremap O :nohlsearch<CR>O
nnoremap o :nohlsearch<CR>o

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

" Neoformat
let g:neoformat_run_all_formatters = 1

" NERDTree
let NERDTreeMouseMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['\.pyc$', '^__pycache__$']

" UltiSnips
let g:UltiSnipsNoPythonWarning = 1
