"=======================================================================
" Generic Configuration

" colorscheme solarized	"主题
colorscheme monokai	"主题
set guifont=consolas:h16:cANSI	"字体

set nocompatible    "设置不兼容原始vi模式
filetype on     "设置开启文件类型侦测
filetype plugin on  "加载对应插件类型
syntax enable       "开启语法高亮功能
syntax on       "自动语法高亮
syntax enable
set number      "开启行号显示
set cursorline      "高亮显示当前行

"=======================================================================
" Plugin

call plug#begin('~/.vim/plugged')

" vim-airline
Plug 'vim-airline/vim-airline'

" nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" nerdtree-git-plugin
Plug 'Xuyuanp/nerdtree-git-plugin'

" rainbow
Plug 'luochen1990/rainbow'

" LeaderF
Plug 'Yggdroot/LeaderF'

" auto-pairs
Plug 'jiangmiao/auto-pairs'

" nerdcommenter
Plug 'preservim/nerdcommenter'

" vim-gutentag
Plug 'ludovicchabant/vim-gutentags'

" tpope/vim-projectionist
Plug 'tpope/vim-projectionist'

" neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"=======================================================================
" Plugin Configuration

" nerdtree
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind if NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()
 
function! ToggleNerdTree()
  set eventignore=BufEnter
  NERDTreeToggle
  set eventignore=
endfunction

nnoremap <leader>t :call ToggleNerdTree()<CR>
"自动开启Nerdtree
autocmd vimenter * NERDTree
"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdtree-git-plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

" rainbow
let g:rainbow_active = 1

" LeaderF
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_ShortcutF = '<leader>f'
noremap <m-f> :LeaderfFunction!<cr>

" ctags
set tags=C:/Users/yhe/Downloads/chromium-main/.tags;,.tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" vim-gutentag
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" tpope/vim-projectionist
let g:projectionist_heuristics = {
\   "*" : {
\       "*.cc": { "alternate": "{}.h" },
\       "*.h": { "alternate": "{}.cc" }
\   }
\ }
nnoremap <silent> <F12> :A<CR>

" neoclide/coc.nvim
let g:coc_node_path = 'C:\Program Files\nodejs\node'
