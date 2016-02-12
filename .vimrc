"require for uname
set shell=/bin/bash

filetype off
let s:uname = system("printf \"$(uname -s)\"")
call pathogen#infect('bundle/{}')
if s:uname == 'Linux'
    call pathogen#infect('bundle-linux/{}')
elseif s:uname == 'Darwin'
    call pathogen#infect('bundle-darwin/{}')
else
    echo "Couldn't find bundle folder for OS type: " + s:uname
endif
filetype plugin indent on

set nocompatible

let mapleader=',' 

set number

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set completeopt=menu,menuone,preview

set scrolloff=2
set autoindent
set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set autowrite
set encoding=utf-8

" Regular expression normalization
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %
nnoremap <leader>f /\v<C-r><C-w><cr>

function! s:tab_or_complete()
  if col('.')>1 && strpart( getline('.'), col('.') - 2, 3 ) =~ '^\w'
    return "\<c-n>"
  else
    return "\<tab>"
  endif
endfunction
inoremap <tab> <c-r>=<sid>tab_or_complete()<cr>

" Text wrapping
set wrap
set textwidth=120
set formatoptions=qrn1

syntax on
set t_Co=256
color janah

set mouse=a
if has('mouse_sgr')
    set ttymouse=sgr
endif

" Split-pane management
nnoremap <M-h> :new<cr>
nnoremap <M-v> :vnew<cr>

" FZF
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction
function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction
function! s:fzf_dirs()
  if exists("g:fzf_root_dirs")
    call fzf#run({'source': "find " . join(g:fzf_root_dirs, ' ') . " -type f", 'sink': 'e', 'down': '40%'})
  else
    call fzf#run()
  endif
endfunction
function! s:fzf_buffers()
  call fzf#run({
        \ 'source': reverse(<sid>buflist()),
        \ 'sink': function('s:bufopen'),
        \ 'options': '+m',
        \ 'down': len(<sid>buflist()) + 2
        \ })
endfunction
    
nnoremap <leader>e :call <sid>fzf_dirs()<cr>
nnoremap <leader>b :call <sid>fzf_buffers()<cr>

map <C-w><C-l> :rightbelow :vnew<cr>
map <C-w><C-h> :leftabove :vnew<cr>
map <C-w><C-j> :belowright :new<cr>
map <C-w><C-k> :aboveleft :new<cr>

nnoremap <left> :bprevious<cr>
nnoremap <right> :bnext<cr>

nnoremap <leader>t :te 

" Podfile/podspec syntax highlighting
au BufNewFile,BufRead Podfile set filetype=ruby
au BufNewFile,BufRead *.podspec set filetype=ruby

au BufNewFile,BufRead *.cpp set filetype=objcpp
au BufNewFile,BufRead *.h set filetype=objcpp
au BufNewFile,BufRead *.m set filetype=objcpp
au BufNewFile,BufRead *.cc set filetype=objcpp
au BufNewFile,BufRead *.hpp set filetype=objcpp
au BufNewFile,BufRead *.mm set filetype=objcpp
au BufNewFile,BufRead *.hh set filetype=objcpp

au BufNewFile,BufRead BUCK set filetype=python

autocmd FileType ruby setlocal shiftwidth=2
autocmd FileType ruby setlocal tabstop=2
autocmd FileType ruby setlocal softtabstop=2

au BufNewFile,BufRead *.go set filetype=go

au BufNewFile,BufRead *.plist set filetype=xml

" FoldingText files
au BufNewFile,BufRead *.ft set filetype=markdown

set wildignore+=Pods/*
set wildignore+=Build/*
set wildignore+=\.git/*
set wildignore+=\.hg/*

" Search for any .vimsettings files in the path to the current file
function! ApplyLocalSettings(dirname)
  let l:netrwProtocol = strpart(a:dirname, 0, stridx(a:dirname, "://"))
  if l:netrwProtocol != ""
    return
  endif

  if a:dirname == ""
    let l:dirname = getcwd()
  else
    let l:dirname = a:dirname
  endif

  let l:curDir = l:dirname " substitute(a:dirname, '', '/', 'g')
  let l:parentDir = strpart(l:curDir, 0, strridx(l:curDir, "/"))
  if isdirectory(l:parentDir)
    call ApplyLocalSettings(l:parentDir)
  endif

  let l:settingsFile = join([l:dirname, ".vimsettings"], '/')
  if filereadable(l:settingsFile)
    exec ":source " . l:settingsFile
  endif
endfunction
autocmd! BufEnter * call ApplyLocalSettings(expand("<afile>:p:h"))

" Session options
set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,resize,tabpages,winsize,winpos

" Commentary
au BufNewFile,BufRead *.cpp set commentstring=//\ %s
au BufNewFile,BufRead *.m set commentstring=//\ %s
au BufNewFile,BufRead *.h set commentstring=//\ %s
au BufNewFile,BufRead *.mm set commentstring=//\ %s
au BufNewFile,BufRead *.cc set commentstring=//\ %s
au BufNewFile,BufRead *.swift set commentstring=//\ %s

" Open in sublime
map <C-o>s :!subl <C-r>%<cr><cr>
