" ʕ◔ϖ◔ʔ Environment variable
if has("win64")
  let $XDG_CONFIG_HOME = expand($LOCALAPPDATA)
  let $XDG_DATA_HOME = expand($LOCALAPPDATA)
  let $XDG_CACHE_HOME  = expand($LOCALAPPDATA.'/nvim/cache')
else
  let $XDG_CONFIG_HOME = expand($HOME.'/.config')
  let $XDG_DATA_HOME = expand($HOME.'/.local/share')
  let $XDG_CACHE_HOME  = expand($HOME.'/.cache')
endif

" ʕ◔ϖ◔ʔ Python path
if has("win64")
  "" ʕ◔ϖ◔ʔ  add python's path to the %PATH% environment variable, 
  ""        or set the following variable
  "let g:python_host_prog =  'P:\ath\to\python2.exe'
  "let g:python3_host_prog = 'P:\ath\to\python3.exe'
else
  "" ʕ◔ϖ◔ʔ if you using pyenv, set $PYENV_ROOT:
  let $PYENV_ROOT = systemlist('pyenv root')[0]
  "" ʕ◔ϖ◔ʔ python path
  let g:python_host_prog =  expand($PYENV_ROOT) . '/shims/python'
  let g:python3_host_prog = expand($PYENV_ROOT) . '/shims/python3'
endif
"" ʕ◔ϖ◔ʔ disable python2
let g:loaded_python_provider = 1

" ʕ◔ϖ◔ʔ Define dein repo path
let s:dein_dir = expand($XDG_CACHE_HOME) . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" ʕ◔ϖ◔ʔ Clone dein.vim repository if it's not exits.
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" ʕ◔ϖ◔ʔ Add the dein installation directory into runtimepath
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let g:dein#install_process_timeout = 9600

if dein#load_state(expand(s:dein_dir))
  call dein#begin(expand(s:dein_dir))

  call dein#add('Shougo/dein.vim')
  if exists('g:gonvim_running')
    call dein#add('akiyosi/gonvim-fuzzy')
  endif

  " ʕ◔ϖ◔ʔ Define dein toml file
  let s:toml_dir  = expand($XDG_CONFIG_HOME) . '/nvim'
  let s:toml_file = s:toml_dir . '/dein.toml'
  call dein#load_toml(s:toml_file, {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

" ʕ◔ϖ◔ʔ Installation check
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable


" ʕ◔ϖ◔ʔ Useful setting
set title
set whichwrap=b,s,h,l
set mouse=a
set ignorecase
set inccommand=split
let mapleader = "\<Space>"
nnoremap <Esc><Esc> :nohlsearch<CR>

" ʕ◔ϖ◔ʔ Gonvim setting
if exists('g:gonvim_running')
  " ʕ◔ϖ◔ʔ Use Gonvim UI instead of vim native UII
  set laststatus=0
  set noshowmode
  set noruler

  " ʕ◔ϖ◔ʔ I use `ripgrep` for :GonvimFuzzyAg
  let g:gonvim_fuzzy_ag_cmd = 'rg --column --line-number --no-heading --color never'

  " ʕ◔ϖ◔ʔ Mapping for gonvim-fuzzy
  nnoremap <leader><leader> :GonvimWorkspaceNew<CR>
  nnoremap <leader>n :GonvimWorkspaceNext<CR>
  nnoremap <leader>p :GonvimWorkspacePrevious<CR>
  nnoremap <leader>ff :GonvimFuzzyFiles<CR>
  nnoremap <leader>fg :GonvimFuzzyAg<CR>
  nnoremap <leader>fb :GonvimFuzzyBuffers<CR>
  nnoremap <leader>fl :GonvimFuzzyBLines<CR>
endif


"" ʕ◔ϖ◔ʔ Your settings here
" set ambiwidth=double   " for multibyte char

