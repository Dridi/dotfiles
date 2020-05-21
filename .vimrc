"
" Defaults
"
let mapleader=','

set autoindent
set autoread
set background=dark
set backspace=eol,indent,start
set backupdir=~/.local/share/nvim/backup,.
set complete=.,b,i,t,w
set directory=~/.local/share/nvim/swap//
set display=lastline
set formatoptions=coqrt
set history=10000
set hlsearch
set laststatus=2
set listchars=eol:¬,tab:▸·
set mouse=
set nrformats=bin,hex
set number
set ruler
set ttyfast
set undodir=~/.local/share/nvim/undo

set noincsearch
set nolangnoremap
set nolist
set nopaste
set nosmarttab

if has('nvim')
  set termguicolors
endif

let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_java_javac_config_file_enabled = 1

"
" Mappings
"
nmap <C-D> :bn<bar>bd#<CR>

nmap <leader>b :call ToggleBackground()<CR>
nmap <leader>c :call ToggleAutoComment()<CR>
nmap <leader>g :!clear && gradle --daemon build<CR>
nmap <leader>h :call ToggleHardWrapping()<CR>
nmap <leader>v :tabedit $MYVIMRC<CR>

nmap <silent> <leader>i :set paste!<CR>:echo 'auto indentation:' &paste<CR>
nmap <silent> <leader>l :set list!<CR>
nmap <silent> <leader>s :set spell!<CR>:echo 'spelling:' &spell<CR>

"
" MYVIMRC
"
if has("autocmd")
  autocmd! BufWritePost $MYVIMRC
  autocmd  BufWritePost $MYVIMRC source $MYVIMRC
endif

"
" vi OCD
"
if has('nvim')
  autocmd InsertLeave * :normal `^
else
  inoremap <silent> <Esc> <Esc>`^
endif

"
" Custom file types
"
if has("autocmd")
  filetype on

  autocmd BufNewFile,BufRead *.am     set filetype=automake
  autocmd BufNewFile,BufRead *.md     set filetype=markdown
  autocmd BufNewFile,BufRead *.vcl    set filetype=perl
  autocmd BufNewFile,BufRead *.vtc    set filetype=perl
  autocmd BufNewFile,BufRead *.vcc    set filetype=rst
  autocmd BufNewFile,BufRead *.jelly  set filetype=xml
  autocmd BufNewFile,BufRead *.gradle set filetype=groovy
endif

"
" Indentation
"
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

if has("autocmd")
  filetype on

  autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab

  autocmd FileType python     setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType xml  setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType svg  setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css  setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType vim  setlocal ts=2 sts=2 sw=2 expandtab
endif

"
" Automatic comments
"
function! ToggleAutoComment()
  try
    if &fo =~ "o"
      set fo-=o
    else
      set fo+=o
    endif
    if &fo =~ "r"
      set fo-=r
    else
      set fo+=r
    endif
  finally
    call SummarizeAutoComment()
  endtry
endfunction

function! SummarizeAutoComment()
  try
    echohl ModeMsg
    echon "Autocomment: insert="
    if &fo =~ "r"
      echon "true"
    else
      echon "false"
    endif
    echon " normal="
    if &fo =~ "o"
      echon "true"
    else
      echon "false"
    endif
  finally
    echohl None
  endtry
endfunction

"
" Hard wrapping
"
let b:hardwrapping=0
nmap <leader>h :call ToggleHardWrapping()<CR>
function! ToggleHardWrapping()
  try
    if b:hardwrapping == 0
      set fo+=ta
      let b:hardwrapping=1
    else
      set fo-=ta
      let b:hardwrapping=0
    endif
  finally
    call SummarizeHardWrapping()
  endtry
endfunction

function! SummarizeHardWrapping()
  try
    echohl ModeMsg
    echon "Hard wrapping: "
    if b:hardwrapping == 0
      echon "disabled"
    else
      echon "enabled"
    endif
  finally
    echohl None
  endtry
endfunction

"
" long lines hunt
"
highlight OverLength ctermbg=red ctermfg=white
highlight TrailingSpaces ctermbg=yellow

au BufEnter,BufWinEnter *  match OverLength     /\%>78v.\+/
au BufEnter,BufWinEnter * 2match TrailingSpaces /\v\s+$/

"
" background
"
function! ToggleBackground()
  if &bg ==# "light"
    set bg=dark
  else
    set bg=light
  endif
endfunction

"
" tmux vs vim
"
if &term =~ '^screen'
  " Page keys
  execute "set t_kP=\e[5;*~"
  execute "set t_kN=\e[6;*~"

  " Arrow keys
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

"
" vim plug
"
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/syntastic', { 'tag': '3.10.0' }
Plug 'bronson/vim-visual-star-search'
Plug 'airblade/vim-gitgutter'
Plug 'lzap/vim-selinux'

call plug#end()
