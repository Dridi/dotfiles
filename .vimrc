"
" Leader key
"
let mapleader=','

"
" .vimrc
"
nmap <leader>v :tabedit $MYVIMRC<CR>

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

"
" Line numbers
"
set number

"
" Invisible characters
"
nmap <leader>l :set list!<CR>
set listchars=tab:▸·,eol:¬

"
" Indentation
"
set ai
nmap <silent> <leader>i :set ai!<CR>
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

  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufNewFile,BufRead *.vcl set filetype=perl
  autocmd BufNewFile,BufRead *.vtc set filetype=perl
  autocmd BufNewFile,BufRead *.jelly set filetype=xml
  autocmd BufNewFile,BufRead *.gradle set filetype=groovy
endif

"
" Automatic comments
"
set fo-=ro
nmap <leader>c :call ToggleAutoComment()<CR>
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
" Spelling
"
nmap <silent> <leader>s :set spell!<CR>

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
" Gradle
"
nmap <leader>g :!clear && gradle --daemon build<CR>

"
" Syntastic
"
let g:syntastic_check_on_wq = 0
let g:syntastic_java_javac_config_file_enabled = 1


"
" :bdelete replacement
"
nmap <C-D> :bp<bar>bd#<CR>

"
" long lines hunt
"
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%>78v.\+/
