" --------------------------------------------------------------------------
" operational settings
set nocompatible                " vim defaults, not vi!
syntax on                       " syntax on
set hidden                      " allow editing multiple unsaved buffers
set more                        " the 'more' prompt
filetype plugin on              " automatic file type detection
set autoread                    " watch for file changes by other programs
set visualbell                  " visual beep
set nobackup                    "no backup files
set nowritebackup               "only in case you don't want a backup file while editing
set noswapfile                  "no swap files
set noautowrite                 " don't automatically write on :next, etc
let maplocalleader=','          " all my macros start with ,
set wildmenu                    " : menu has tab completion, etc
set wildmode=longest,list:longest,list:full
set scrolloff=5                 " keep at least 5 lines above/below cursor
set sidescrolloff=5             " keep at least 5 columns left/right of cursor
set history=200                 " remember the last 200 commands
set guioptions+=a               " selecting any text would override your MS clipboard
set tabstop=4
set softtabstop=0
set shiftwidth=4
set smarttab
set autoindent
set noexpandtab

colorscheme desert
set guifont=Inconsolata\ Medium\ 10
"hi ColorColumn ctermbg=lightred guibg=lightred
let Tlist_Auto_Open = 1
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 50

set nu
" save file mapping
map <silent> <f2> :w<CR>
map <silent> <f4> :TlistToggle<cr>
" bufferexplorer
map <f3> \be
" NerdTree
map <f5> :NERDTreeToggle<CR>

" vimrc edit/load
map ,cv :e ~\vimfiles\vimrc<CR>
map ,cs :source ~\vimfiles\vimrc<CR>

" this makes the mouse paste a block of text without formatting it 
" (good for code)
map <MouseMiddle> <esc>"*p

" ---------------------------------------------------------------------------
" global editing settings
set undolevels=1000             " number of forgivable mistakes
set updatecount=100             " write swap file to disk every 100 chars
set complete=.,w,b,u,U,t,i,d    " do lots of scanning on tab completion
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo

" ---------------------------------------------------------------------------
" searching...
set hlsearch                   " enable search highlight globally
set incsearch                  " show matches as soon as possible
set showmatch                  " show matching brackets when typing
" disable last one highlight
nmap <LocalLeader>nh :nohlsearch<cr>
set diffopt=filler,iwhite       " ignore all whitespace and sync

" ---------------------------------------------------------------------------
" spelling...
if v:version >= 700
  let b:lastspelllang='en'
  function! ToggleSpell()
    if &spell == 1
      let b:lastspelllang=&spelllang
      setlocal spell!
    elseif b:lastspelllang
      setlocal spell spelllang=b:lastspelllang
    else
      setlocal spell spelllang=en
    endif
  endfunction

  nmap <LocalLeader>ss :call ToggleSpell()<CR>

  setlocal spell spelllang=en
  setlocal nospell
endif

" ---------------------------------------------------------------------------
" some useful mappings

" disable search complete
let loaded_search_complete = 1

" Y yanks from cursor to $
map Y y$
" toggle list mode
nmap <LocalLeader>tl :set list!<cr>
" toggle paste mode
nmap <LocalLeader>pp :set paste!<cr>
" change directory to that of current file
nmap <LocalLeader>cd :cd%:p:h<cr>
" change local directory to that of current file
nmap <LocalLeader>lcd :lcd%:p:h<cr>

" word swapping
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l>
" char swapping
nmap <silent> gc xph

" this is for the find function plugin
nmap <LocalLeader>ff :let name = FunctionName()<CR> :echo name<CR> 

" status line 
set laststatus=2
if has('statusline')
        function! SetStatusLineStyle()
                let &stl="%f %y "                       .
                        \"%([%R%M]%)"                   .
                        \"%#StatusLineNC#%{&ff=='unix'?'':&ff.'\ format'}%*" .
                        \"%{'$'[!&list]}"               .
                        \"%{'~'[&pm=='']}"              .
                        \"%="                           .
                        \"#%n %l/%L,%c%V "              .
                        \""
        endfunc
        call SetStatusLineStyle()

        if has('title')
                set titlestring=%t%(\ [%R%M]%)
        endif
endif
" =============================================================================
" Project configuration

:let g:src_prefix = "/local/mnt/workspace/"
:let g:src_suffix = ""
:let $PROJ_PATH = ""

" Path arrays, middle part: "g:src_prefix . g:code_path[a:path_index] . g:src_suffix"
" Where g:code_path[a:path_index] taken from the array
let g:code_path = [ "IMM.LE.1.0/sources/kernel", "IMM.LE.1.0/sources/vendor/qti", "gits/linux"]
let g:work_area_index = 0

" Project menu items
amenu &Project.imm-kernel  	 	 :call SetEnvironment(0)<CR>
amenu &Project.imm-sources               :call SetEnvironment(1)<CR>
amenu &Project.linux                     :call SetEnvironment(2)<CR>
"amenu &Project.Napali_nvm               :call SetEnvironment(3)<CR>


function! SetEnvironment(index)
    let $PROJ_PATH = g:src_prefix . g:code_path[a:index] . g:src_suffix
    let $path_index = a:index
    let g:work_area_index = a:index
    cd $PROJ_PATH
    " refresh cscope connection (if exists)
    cs kill 0
    cs add .
    " call NERDTreeCWD()
endfunction

"----------------------------------------------------------------------------- Default compilation/project settings
call SetEnvironment(g:work_area_index)
"----------------------------------------------------------------------------- EOF Default compilation/project settings
let $TMP="/tmp"

execute pathogen#infect()
