set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')
Plugin 'bling/vim-airline'

Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'ycm-core/YouCompleteMe'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'ervandew/supertab'

Plugin 'tpope/vim-fugitive'
Plugin 'sheerun/vim-polyglot'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'mattn/emmet-vim'
Plugin 'ap/vim-css-color'

Plugin 'mhinz/vim-startify'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'morhetz/gruvbox'
call vundle#end()
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden
set backspace=indent,eol,start
set clipboard+=unnamedplus
set laststatus=2
set updatetime=200
set completeopt=menuone,preview,noinsert

let mapleader="\<space>"
syntax on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>f :GFiles<cr>
nnoremap <leader>b :Buffers<cr>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Change tabs
nnoremap <silent> <m-]> :bnext<cr>
nnoremap <silent> <m-[> :bprev<cr>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Switch to previous file
nnoremap <leader><leader> <c-^>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"nnoremap <silent> <c-]> :YcmCompleter GoToDefinition<cr>

nmap <F8> :TagbarToggle<CR>

" Remap keys for gotos
map <leader>cd <Plug>(coc-definition)
" Remap for rename current word
nmap <leader>crn <Plug>(coc-rename)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup python
  au!
  autocmd FileType python call SetPythonOptions()
augroup END

augroup javascript
  au!
  autocmd FileType js,jsx,javascript,vue call SetJavaScriptOptions()
augroup END

augroup java
  au!
  autocmd FileType java call SetJavaOptions()
augroup END

augroup other
  autocmd!
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
  autocmd BufEnter * :syntax sync fromstart
augroup END

function SetJavaScriptOptions()
  set number showmatch
  set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent
endfunction

function SetPythonOptions()
  set number showmatch
  set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent
  let python_highlight_all = 1
endfunction

function SetJavaOptions()
  set autoindent
  set si
  set shiftwidth=4
  set cinoptions+=j1
  let java_comment_strings=1
  let java_highlight_java_lang_ids=1
  let java_mark_braces_in_parens_as_errors=1
  let java_highlight_all=1
  let java_highlight_debug=1
  let java_ignore_javadoc=1
  let java_highlight_java_lang_ids=1
  let java_highlight_functions="style"
  let java_minlines = 150
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_Co=256 " 256 colors
let g:gruvbox_italic=1
"let g:gruvbox_contrast_dark='hard'
set background=dark
colorscheme gruvbox

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHORTCUT TO REFERENCE CURRENT FILE'S PATH IN COMMAND LINE MODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <expr> %% expand('%:h').'/'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>
let g:vue_pre_processors = []

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTREE SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeIgnore=['\.pyc$', '__pycache__', 'node_modules']

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! CheckIfCurrentBufferIsFile()
  return strlen(expand('%')) > 0
endfunction

function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && CheckIfCurrentBufferIsFile() && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

autocmd BufRead * call SyncTree()

" Toggle tree for active buffer
function! ToggleTree()
  if CheckIfCurrentBufferIsFile()
    if IsNERDTreeOpen()
      NERDTreeClose
    else
      NERDTreeFind
    endif
  else
    NERDTree
  endif
endfunction

nmap <C-n> :call ToggleTree()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM AIRLINE SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_c = '%t'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#unicode#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#vista#enabled = 1
let g:airline#extensions#hunks#enabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Define Error Symbols and colors
let g:coc_status_warning_sign = ''
let g:coc_status_error_sign = ''
hi CocWarningSign ctermfg=yellow 
hi CocErrorSign ctermfg=red
hi CocInfoSign ctermfg=blue
hi CocHintSign ctermfg=green

" Transparent popup window
hi! Pmenu ctermbg=black
hi! PmenuSel ctermfg=2
hi! PmenuSel ctermbg=0

" Brighter line numbers
hi! LineNr ctermfg=NONE guibg=NONE

set updatetime=300
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" coc-eslint needs eslint npm package installed globally
let g:coc_global_extensions = [
      \'coc-html', 
      \'coc-css', 
      \'coc-prettier',
      \'coc-eslint',
      \'coc-vetur',
      \'coc-emmet',
      \'coc-json',
      \'coc-python',
      \'coc-yaml',
      \]

augroup MyAutoCmd
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! s:with_git_root()
  "let root = systemlist('git rev-parse --show-toplevel')[0]
  "return v:shell_error ? {} : {'dir': root}
"endfunction

"command! -nargs=* Rag
  "\ call fzf#vim#ag(<q-args>, extend(s:with_git_root(), g:fzf#vim#default_layout))
