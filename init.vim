
" Define environment variable
let $XDG_CONFIG_HOME = '~/.config'
let $XDG_CACHE_HOME  = '~/.cache'

" Define dein repo path
let s:dein_dir = expand($XDG_CACHE_HOME) . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Clone dein.vim repository if it's not exits.
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" Add the dein installation directory into runtimepath
let &runtimepath = s:dein_repo_dir .",". &runtimepath

if dein#load_state(expand(s:dein_dir))
  call dein#begin(expand(s:dein_dir))

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('akiyosi/gonvim-fuzzy')

  " Define dein toml file
  let s:toml_dir  = expand($XDG_CONFIG_HOME) . '/nvim'
  let s:toml_file = s:toml_dir . '/dein.toml'
  call dein#load_toml(s:toml_file, {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

" Installation check.
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable


" I use Gonvim UI instead of following
set laststatus=0
set noshowmode

" Useful setting
set whichwrap=b,s,h,l


" Mapping for gonvim-fuzzy
let mapleader = "\<Space>"
nnoremap <leader><leader> :GonvimWorkspaceNew<CR>
nnoremap <leader>n :GonvimWorkspaceNext<CR>
nnoremap <leader>p :GonvimWorkspacePrevious<CR>
nnoremap <Space>ff :GonvimFuzzyFiles<CR>
nnoremap <Space>fg :GonvimFuzzyAg<CR>
nnoremap <Space>fb :GonvimFuzzyBuffers<CR>
nnoremap <Space>fl :GonvimFuzzyBLines<CR>
