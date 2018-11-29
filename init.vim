" Environment variable
if has("win64")
  let $XDG_CONFIG_HOME = expand($LOCALAPPDATA)
  let $XDG_DATA_HOME = expand($LOCALAPPDATA)
  let $XDG_CACHE_HOME  = expand($LOCALAPPDATA.'/nvim/cache')
else
  let $XDG_CONFIG_HOME = expand($HOME.'/.config')
  let $XDG_DATA_HOME = expand($HOME.'/.local/share')
  let $XDG_CACHE_HOME  = expand($HOME.'/.cache')
endif

" Python path
if has("win64")
  "" add python's path to the %PATH% environment variable, 
  "" or set the following variable
  "let g:python_host_prog =  'P:\ath\to\python2.exe'
  "let g:python3_host_prog = 'P:\ath\to\python3.exe'
else
  "" if you using pyenv:
  let $PYENV_ROOT = systemlist('pyenv root')[0]
  "" python path
  let g:python_host_prog =  expand($PYENV_ROOT) . '/shims/python'
  let g:python3_host_prog = expand($PYENV_ROOT) . '/shims/python3'
endif
"" disable python2
let g:loaded_python_provider = 1

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

  call dein#add('Shougo/dein.vim')
  call dein#add('akiyosi/gonvim-fuzzy')

  " Define dein toml file
  let s:toml_dir  = expand($XDG_CONFIG_HOME) . '/nvim'
  if has("win64")
    let s:toml_file = s:toml_dir . '/dein-win.toml'
  else
    let s:toml_file = s:toml_dir . '/dein.toml'
  endif
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
set noruler


" Useful setting
set whichwrap=b,s,h,l
set ignorecase
nnoremap <Esc><Esc> :nohlsearch<CR>


" Mapping for gonvim-fuzzy
let mapleader = "\<Space>"
nnoremap <leader><leader> :GonvimWorkspaceNew<CR>
nnoremap <leader>n :GonvimWorkspaceNext<CR>
nnoremap <leader>p :GonvimWorkspacePrevious<CR>
nnoremap <Space>ff :GonvimFuzzyFiles<CR>
nnoremap <Space>fg :GonvimFuzzyAg<CR>
nnoremap <Space>fb :GonvimFuzzyBuffers<CR>
nnoremap <Space>fl :GonvimFuzzyBLines<CR>

