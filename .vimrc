" Initialize Pathogen
call pathogen#infect()
Helptags

" Basic Vim settings {{{

set t_Co=256
set incsearch number showcmd
set autoindent smartindent tabstop=4 shiftwidth=4 shiftround
set listchars=tab:▹—,trail:$,extends:>,precedes:<,eol:¬,nbsp:·

set copyindent                  " Preserve vertical alignment when indenting
set scrolloff=3                 " Give more context when scrolling
set wildmode=list:longest,full  " Make commands/files autocomplete like Bash
set wildmenu                    " Show keyword list of tab autocomplete
set t_Co=256                    " Fix colour issues when running in tmux
set formatoptions-=t            " Don't auto-wrap text everywhere

set textwidth=80
set colorcolumn=81              " Highlight long lines

set statusline=%f\ %m%h%r%w\ %y\ %{fugitive#statusline()}%=\ B%3n\ ·\ L%5l/%5L\ ·\ C%7(%c%V%)\ ·\ %4(0x%B%)\ ·\ %P
set rulerformat=%45(%=B%3n\ ·\ L%5l/%5L\ ·\ C%7(%c%V%)\ ·\ %4(0x%B%)\ ·\ %P%)

set directory=~/tmp//,/tmp//
set backupdir=~/tmp//,/tmp//

syntax on

" }}}
" Gvim options {{{

set guifont=Liberation\ Mono\ 10
set guioptions-=e
set guioptions-=r
set guioptions-=T
set guioptions-=L
set guioptions-=m

" }}}
" Colour scheme {{{

set background=dark

if has("gui_running")
	color frost-gui
else
	color frost
endif

" }}}
" Filetype-specific settings {{{

filetype plugin on

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType php set comments=sr:/*,mb:*,ex:*/,://
autocmd FileType php,javascript,python set formatoptions=croqn1

" }}}
" Mappings {{{

set pastetoggle=<Leader>p

nnoremap <Leader>z :sp ~/.vimrc<CR>
nnoremap <Leader>x :so %<CR>

nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <Leader>F :NERDTreeMirror<CR>
nnoremap <Leader>T :TagbarToggle<CR>

nnoremap <Leader>g :IndentGuidesToggle<CR>

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
nnoremap <Leader>= :Tabular equals<CR>
vnoremap <Leader>= :Tabular equals<CR>

" Write with sudo
cnoremap w!! w !sudo tee % > /dev/null

" Chording
let g:arpeggio_timeoutlen=20
call arpeggio#load()

Arpeggio noremap ne <Esc>
Arpeggio inoremap ne <Esc>
Arpeggio cnoremap ne <C-c>

Arpeggio inoremap ei <Esc>:call UltiSnips#JumpForwards()<CR>
Arpeggio inoremap st <C-n>
Arpeggio inoremap rs <C-p>

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

" }}}
