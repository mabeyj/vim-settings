" Initialize Pathogen
call pathogen#infect()
Helptags

" Basic Vim settings
set incsearch mouse=a number showcmd
set autoindent tabstop=4 shiftwidth=4
set formatoptions+=12cnoqr
set listchars=tab:>\ ,trail:$
set scrolloff=3                 " Give more context when scrolling
set wildmode=list:longest,full  " Make commands/files autocomplete like Bash
set wildmenu                    " Show keyword list of tab autocomplete
set colorcolumn=81              " Highlight long lines

set statusline=%f\ %m%h%r%w\ %y\ %{fugitive#statusline()}%=\ B%3n\ ·\ L%5l/%5L\ ·\ C%7(%c%V%)\ ·\ %4(0x%B%)\ ·\ %P
set rulerformat=%45(%=B%3n\ ·\ L%5l/%5L\ ·\ C%7(%c%V%)\ ·\ %4(0x%B%)\ ·\ %P%)

" Gvim options
set guifont=Monospace\ 8
set guioptions-=e
set guioptions-=r
set guioptions-=T
set guioptions-=L

" Colour scheme
set background=dark
color xoria256
hi Normal ctermbg=none
hi NonText ctermbg=none

" Trim trailing spaces for certain filetypes
function! <SID>TrimTrailingWhitespace()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfunction

autocmd BufWritePre *.php,*.py,*.css,*.html,*.js :call <SID>TrimTrailingWhitespace()

" Filetype-specific settings
" ------------------------------------------------------------------------------
filetype plugin on
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" Only continue doc comment structures
autocmd FileType php        set comments=s:/*,mb:\ *,ex:*/
autocmd FileType javascript set comments=s:/*,mb:\ *,ex:*/

" Show cached diff when committing with Git
autocmd FileType gitcommit DiffGitCached | wincmd L
" ------------------------------------------------------------------------------

" Mappings
" ------------------------------------------------------------------------------
set pastetoggle=<Leader>p

nnoremap <Leader>z :sp ~/.vimrc<CR>
nnoremap <Leader>x :so ~/.vimrc<CR>

nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <Leader>F :NERDTreeMirror<CR>
nnoremap <Leader>d :TagbarToggle<CR>

" Align key/value pairs -- would like to avoid using a mark, but Align acts
" weird when used in a function
autocmd FileType php        nnoremap <Leader>k mZ:AlignCtrl lp1P1:<CR>[(jV])k:Align =><CR>`Z
autocmd FileType php        vnoremap <Leader>k <Esc>:AlignCtrl lp1P1:<CR>:Align =><CR>
autocmd FileType javascript vnoremap <Leader>k <Esc>:AlignCtrl l<p0P0:<CR>:'<,'>Align " "<CR>

" Align doc comment @param descriptions
vnoremap <Leader>j :s/  \+/  /g<CR>:AlignCtrl lp0P0:<CR>:'<,'>Align "  "<CR>

" Fix indentation of doc comments
nnoremap <Leader>c ?\/\*\*<CR>V/\*\/<CR>=``

" Write with sudo
cnoremap w!! w !sudo tee % > /dev/null

" Hit jk at same time to trigger Esc
call arpeggio#load()
Arpeggio noremap! jk <Esc>
" ------------------------------------------------------------------------------

" Plugin settings
" ------------------------------------------------------------------------------
" Indent guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0

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

" Snipmate
let g:snipMate={'scope_aliases': {'php': 'php'}}  " Don't mix other snippets with PHP
" ------------------------------------------------------------------------------
