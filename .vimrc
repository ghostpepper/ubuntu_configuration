" Author: Paul Epperson, 2016                                                  "
" ~/.vimrc: runtime configuration for vim                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on						" Turn on syntax coloring
set nocompatible				" Turn off vi restrictions (redundant)
set noexrc						" Turn off insecure directory exceptions (old)
set nomodeline					" Turn off insecure file exceptions (old)
set nowrap						" Turn off line wrapping
set number						" Turn on line numbering
set showmode					" Turn on current edit mode display (redundant)
set noerrorbells				" Turn off error bells
set autoindent					" Turn on same-as-previous-line indentation
set cindent						" Turn on indents for C,CPP programs
set gdefault					" Turn on global search in search
set ignorecase					" Turn off case checking in search
set nohlsearch					" Turn off search highlighting
set incsearch					" Turn on moving to best search before complete
set nojoinspaces				" Turn off spaces after joined sentences
set autoread					" Turn on some file change detections
set fileformats=unix,dos,mac	" Turn on terminator acceptance for common OS's
set backspace=indent,eol,start	" Turn on backspacing over formatting characters
set showmatch					" Turn on view of opening brackets when closed
set scrolloff=999				" Turn on centering cursor when scrolling
set t_Co=256					" Turn on 256 colors in terminal 
set background=light			" Turn on syntax light-background syntax colors

" Remove visual bells
set novisualbell t_vb=
au GUIEnter * set novisualbell t_vb=

" Highlighting past 80 columns
highlight OverLength ctermbg=red ctermfg=white guibg=#FFD9D9
au BufRead,BufNewFile *.{c,cpp,h,hpp,java,py,js,rb} match OverLength /\%81v.\+/

" Set/Don't set tab expansion:
au BufRead,BufNewFile *.{c,cpp,h,hpp,java,py,js,rb} set expandtab
au BufRead,BufNewFile {*.s,Makefile,.gitconfig,.vimrc} set noexpandtab

" Set tab, shift width to 2 (shifts: {<<,>>})
au BufRead,BufNewFile *.{c,cpp,h,hpp,java,js,rb} set shiftwidth=2
au BufRead,BufNewFile *.{c,cpp,h,hpp,java,js,rb} set tabstop=2

" Set tab, shift width to 4
au BufRead,BufNewFile {*.{s,py},Makefile,.gitconfig,.vimrc} set shiftwidth=4
au BufRead,BufNewFile {*.{s,py},Makefile,.gitconfig,.vimrc} set tabstop=4

" Save on focus loss, Reload on focus regained
au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w

" Move between windows
map <C-j> <C-W>j<C-W>
map <C-k> <C-W>k<C-W>
map <C-h> <C-W>h<C-W>
map <C-l> <C-W>l<C-W>

" Foil sudo permissions required to write to file
cmap w!! w !sudo tee > /dev/null %

" Search results appear in middle of screen
nnoremap n nzz
nnoremap N nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Permanent EGREP-style regular expressions during search/substitutions
:nnoremap / /\v
:cnoremap %s/ %s/\v 

" Toggling between matching objects with % in Visual mode selects inclusive text
noremap % v%

" Toggle between matching brackets/parentheses with %, and scroll if need be
au VimEnter * DoMatchParen
inoremap } }<Left><c-o>%<c-o>:sleep 500m<CR><c-o>%<c-o>a
inoremap ] ]<Left><c-o>%<c-o>:sleep 500m<CR><c-o>%<c-o>a
inoremap ) )<Left><c-o>%<c-o>:sleep 500m<CR><c-o>%<c-o>a

" Delete trailing whitespace on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
au BufWrite * :call DeleteTrailingWS()

" Add spell checking, wrapping, and cursor at beginning for commit messages
au Filetype gitcommit setlocal spell textwidth=72
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])    

" Add spell checking toggle via F10 and F11 (gvim)
map <F10> <Esc>:setlocal spell spelllang=en_us<CR>	
map <F11> <Esc>:setlocal nospell<CR>

" Pretty colors
try
	colorscheme solarized
catch
endtry
