call pathogen#runtime_append_all_bundles() 

set number
set showcmd
set mouse=a
set history=1000
set undolevels=1000
set hidden
set incsearch
set showtabline=2

set scrolloff=3            " Give more context when scrolling
set wildmode=list:longest  " Make commands/files autocomplete like Bash

" Show date/time in ruler
set rulerformat=%55(%{strftime('%a\ %F\ %I:%M:%S\ %p')}\ \ L%5l/%5L\ \ C%7(%c%V%)\ \ %P%)

" Function keys
set pastetoggle=<F2>
nnoremap <silent> <F9> :TagbarToggle<CR>
map <F12> :NERDTreeToggle<CR>

" Write with sudo
cmap w!! w !sudo tee % >/dev/null

" Indentation
set autoindent
set tabstop=4
set shiftwidth=4

" Highlight long lines
set colorcolumn=81
hi ColorColumn ctermbg=233

" GUI
set guifont=Monospace\ 9
set guioptions-=m
set guioptions-=T
set guiheadroom=0

" kj triggers ESC
inoremap jk <Esc>
inoremap kj <Esc>

" Trim trailing spaces for certain filetypes
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre *.php,*.css,*.html,*.js :call <SID>StripTrailingWhitespaces()

" Filetype-specific settings
filetype plugin indent on
au FileType php set omnifunc=phpcomplete#CompletePHP

" Only continue comment structure after pressing <Enter> for doc comments
au FileType php set comments=s:/*,mb:\ *,ex:*/
au FileType javascript set comments=s:/*,mb:\ *,ex:*/

" Colour scheme
color sunburst
set background=dark
hi Normal ctermbg=none
hi NonText ctermbg=none

" Indent guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0

hi IndentGuidesOdd ctermbg=234
hi IndentGuidesEven ctermbg=233

" Tagbar
let g:tagbar_autofocus=1

" NERDTree
let NERDTreeMouseMode=2
