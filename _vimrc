" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"=======================================================================
" Generic Configuration

colorscheme solarized	"主题
set guifont=consolas:h16:cANSI	"字体

set nocompatible    "设置不兼容原始vi模式
filetype on     "设置开启文件类型侦测
filetype plugin on  "加载对应插件类型
syntax enable       "开启语法高亮功能
syntax on       "自动语法高亮
set number      "开启行号显示
set cursorline      "高亮显示当前行

"=======================================================================
" Plugin

call plug#begin('~/.vim/plugged')

" vim-airline
Plug 'vim-airline/vim-airline'

" nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
nnoremap <leader>t :NERDTreeToggle<CR>

" rainbow
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" LeaderF
Plug 'Yggdroot/LeaderF'
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_ShortcutF = <leader>f

" auto-pairs
Plug 'jiangmiao/auto-pairs'

call plug#end()
