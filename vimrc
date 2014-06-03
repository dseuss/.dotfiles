" vim: set fdm=marker expandtab ts=2 sw=2 foldnestmax=2:
"
" Vim configuration file - Daniel Suess
" Last modified: 2013-09-20
"-----------------------------------------------------------------------------

"" Posible combinations: (ycm, ultisnips), (neocomplete, ultisnips),
""                       (neocomplete, neosnippet)
if has('gui_running')
  "" use neocomplete for prose writing
  let completer = 'neocomplete'
else
  "" for real coding use youcompleteme
  " let completer = 'ycm'
  let completer = 'neocomplete'
endif

let completer = 'ycm'
let snipper = 'ultisnips'

" INITIAL SETUP {{{1

"" Disable compatibility to vi mode
set nocompatible
"" Needs to be unset for Vundle, remember to reset after all packages are loaded
filetype off

"" Load Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'


" KEY SETTINGS {{{1
" vim-repeat -- repeat commands in tpope plugins{{{2
Bundle 'tpope/vim-repeat'


" vim-unimpaired -- pairs commands using bracket mappings {{{2
Bundle 'tpope/vim-unimpaired'

" SuperTab -- share the tab key {{{2
if snipper ==? 'ultisnips'
  Bundle 'ervandew/supertab'

  "" Sync with YouCompleteMe
  let g:SuperTabDefaultCompletionType = '<S-TAB>'
endif

"2}}}

"" remap leader key for German layout
let mapleader = ' '

"" Set marks using Ü, since m is used by vim-seek
noremap Ü m

"" Fix the yank-inconsistency (Y yanks to end of line)
nnoremap Y y$
"" show yank registers
nnoremap <silent> <LEADER>sr :reg<CR>

"" time between consecutive key presses noted as string
set ttimeoutlen=50

"" easy acces to external commands
nnoremap ! :!

"" enable/disable virtualedit
nnoremap [ov :set virtualedit=all<CR>
nnoremap ]ov :set virtualedit=block<CR>

"" switch between tabs
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tN :tabnew<CR>

" APPERANCE & BEHAVIOR {{{1

" vim-airline -- pure vimscript replacement for powerline {{{2
Bundle 'bling/vim-airline'

"" Theme is set below together with colorscheme
"" Use powerline fonts
let g:airline_powerline_fonts = 1
"" Disable python-virtualenv plugin
let g:airline#extensions#virtualenv#enabled = 0

nnoremap coa :AirlineToggle<CR>

" vim-colors-solarized -- solarized color scheme {{{2
Bundle 'altercation/vim-colors-solarized'

" vim-startify -- startup screen {{{2
Bundle 'mhinz/vim-startify'

let g:startify_custom_header = [
      \' _    ___                                          __   _____  _____',
      \'| |  / (_)___ ___  ____  _________ _   _____  ____/ /  /__  / |__  /',
      \'| | / / / __ `__ \/ __ \/ ___/ __ \ | / / _ \/ __  /     / /   /_ < ',
      \'| |/ / / / / / / / /_/ / /  / /_/ / |/ /  __/ /_/ /     / /_ ___/ / ',
      \'|___/_/_/ /_/ /_/ .___/_/   \____/|___/\___/\__,_/     /_/(_)____/  ',
      \'                     /_/                                            '
      \ ]

"" session options -- dont save option
set ssop-=options
"2}}}

"" Set colorscheme depending on terminal/gui-vim
if &t_Co >= 256
  "" 256-color terminal
  "let g:airline_theme="powerlineish"
  colorscheme zenburn
endif
if has('gui_running')
  colorscheme solarized
  set background=light
  set guifont=Anonymous\ Pro\ for\ Powerline\ 11
endif

"" show cursorline
set cursorline

"" relative line numbering with absolute numbering of current line
set relativenumber
set number
"" Hide all line numbers for quickfix, taglist, etc.
au FileType qf,taglist, set norelativenumber|set nonumber

"" always show status line
set laststatus=2

"" Dont show status there, we have airline
set noshowmode

"" use syntax highlighting
syntax on

"" Better performance
set nottyfast
set lazyredraw

"" dont beep, please
set novisualbell

" MOUSE & GUI {{{1

"" Show a shell in gvim (since c-z suspends in terminal session)
if has('gui_running')
  " for gvim
  nnoremap <silent> <c-z> :shell<CR>
endif

"" autoselect in visual mode, use simple dialogs, icon, grey menus
set guioptions=acig

"" Scrolling with mouse wheel, even in tmux
set mouse=a
"" And open a menu on right click in gvim
set mousemodel=popup
"" hide cursor when typing
set mousehide


" WINDOW & BUFFER MANAGMENT {{{1

" bclose -- close current buffer, open empty file if it's the last {{{2
Bundle 'rbgrouleff/bclose.vim'

" Close active window buffer file
nnoremap <silent> <LEADER>bc :Bclose<CR>


" vim-bufferline -- Display bufferlist in statusline {{{2
"Bundle 'bling/vim-bufferline'
"" Dont print messages in statusline
let g:bufferline_echo = 0


" show & hide quickfix/location list {{{2
function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
    echohl ErrorMsg
    echo "Location List is Empty."
    return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

function! OpenList(pfx)
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

function! CloseList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
endfunction

nnoremap <silent> coo :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> [oo :call OpenList('l')<CR>
nnoremap <silent> ]oo :call CloseList("Location List", 'l')<CR>
nnoremap <silent> coq :call ToggleList("Quickfix List", 'c')<CR>
nnoremap <silent> [oq :call OpenList('c')<CR>
nnoremap <silent> ]oq :call CloseList("Quickfix List", 'c')<CR>


" Always show/hide quickfix window when it gets populated {{{2
" function! ToggleListAC(pfx)
"   let winnr = winnr()
"   exec(a:pfx.'window')
"   if winnr() != winnr
"     wincmd p
"   endif
" endfunction
" autocmd QuickFixCmdPost [^l]* nested call ToggleListAC('c')
" autocmd QuickFixCmdPost    l* nested call ToggleListAC('l')


" set the height of the preview windows {{{2
function! PreviewHeightWorkAround(previewheight)
  if &previewwindow
    exec 'setlocal winheight='.a:previewheight
  endif
endfunction

au BufEnter ?* call PreviewHeightWorkAround(5)

" control size and lication of quickfix/location list {{{2
"" https://gist.github.com/juanpabloaj/5845848
function! AdjustWindowHeight(minheight, maxheight)
  let l = 1
  let n_lines = 0
  let w_width = winwidth(0)
  while l <= line('$')
    " number to float for division
    let l_len = strlen(getline(l)) + 0.0
    let line_width = l_len/w_width
    let n_lines += float2nr(ceil(line_width))
    let l += 1
  endw
  exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

"" Set quickfixwindow height to fit the number of errors, but 10 max, 3 min
autocmd FileType qf call AdjustWindowHeight(3, 10)
"" ..and open on bottom of screen
autocmd FileType qf wincmd J


" vim-accordion -- manage vsplits {{{2
Bundle 'mattboehm/vim-accordion'

"2}}}

"" Scroll through windows with hjkl
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

"" close all but active window
nnoremap <silent> <leader>q :only<CR>

"" close current buffer
nnoremap <C-q> :q<CR>


" TEXT EDITING {{{1

" Align -- align text in neat tables {{{2
set rtp+=~/.vim/sbundle/Align


" fill lines with certain character {{{2
function! FillLine()
  "" grap the correct fill char
  if exists('b:fillchar')
    let fillchar = b:fillchar
  elseif exists('g:fillchar')
    let fillchar = g:fillchar
  else
    return
  endif

  "" set tw to the desired total length
  let tw = &textwidth
  if tw==0 | let tw = 80 | endif
  "" strip trailing spaces first
  "".s/[[:space:]]*$//
  "" calculate total number of 'str's to insert
  let reps = (tw - col("$") + 1) / len(fillchar)
  "" insert them, if there's room, removing trailing spaces (though forcing
  "" there to be one)
  if reps > 0
    .s/$/\=(''.repeat(fillchar, reps))/
  endif
endfunction

let g:fillchar = '-'
nnoremap <silent> <leader>cf :call FillLine()<CR>


" GUNDO -- graphical representation of undo tree {{{2
Bundle 'sjl/gundo.vim'

nnoremap cog :GundoToggle<CR>
nnoremap [og :GundoShow<CR>
nnoremap ]og :GundoHide<CR>
command! Gundo GundoToggle

" Mark--Karkat -- mark text, words with colors {{{2
"" Dont use github, since we disabled all default mappings
set rtp+=~/.vim/sbundle/Mark--Karkat/

"" mark with §, clear with <leader>§
if !hasmapto('<Plug>MarkSet', 'n')
  nmap <unique> <silent> § <Plug>MarkSet
endif
if !hasmapto('<Plug>MarkSet', 'v')
  vmap <unique> <silent> § <Plug>MarkSet
endif
nnoremap <silent> <leader>§ :MarkClear<CR>


" nerd-comment -- insert/delete/modify comments {{{2
Bundle 'scrooloose/nerdcommenter'

"" Always add a space in front of text when commented
let NERDSpaceDelims = 1

" remove trailing whitspaces on save {{{2
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


" synastic -- on-the-fly code checking {{{2
Bundle 'scrooloose/syntastic'

"" Always show errors on save
let g:syntastic_always_populate_loc_list=1

"" Syntastics for python, only use flake8
let g:syntastic_python_checkers=['flake8']
"" Ignore certain errors and check complexity
let g:syntastic_python_flake8_post_args='--ignore=E127,E128,E226 --max-complexity 10'
"" E127, E128 -- continuation line is over indented
"" E226 -- white space around operator (since x**2 looks way better then x ** 2)

let g:syntastic_tex_chktex_post_args='--nowarn 1'
"" 1 -- Command terminated with space

" UnconditionalPaste -- Paste registers linewise/characterwise {{{2
"Bundle 'mutewinter/UnconditionalPaste'

" vim-multiple-cursor -- many cursors, may good {{{2
Bundle 'terryma/vim-multiple-cursors'


" vim-surround -- handling quotes, parentheses, tags, ... {{{2
Bundle 'tpope/vim-surround'

"" Reindent after insertion
let g:surround_indent = 1
"" Since I never use select, remap to surround
nmap S ys
nmap SS yss


" text indenation and breaking {{{2
"" indenting uses spaces
set smarttab
set expandtab
"" indent automatically
set autoindent
"" indent newline
set copyindent


"" set default indention to 3 spaces
set tabstop=3
set shiftwidth=3
set softtabstop=3


"" Break only whole words
set linebreak
set formatoptions=croq
"" Use soft linebreaks
set wrap
"au FileType qf, set wrap
"" linewraping respects indentation (requires breakindent patch)
set showbreak=
set breakindent

"" use 79 colum textwidth and display "forbidden column"
set textwidth=79
set colorcolumn=80

"2}}}


"" Sane backspace key
set backspace=indent,eol,start
"" with ctrl-bs deleting the last word
inoremap <C-BS> <C-W>

"" cursor may be placed anywhere in block selection mode
set virtualedit=block

"" always show some lines/columns arround cursor
set scrolloff=1
set sidescrolloff=0
set display+=lastline

"" show hidden characters, but hide on default
set listchars=trail:⋅,eol:¬,tab:▸\
set nolist

"" use Q for formatting selection/paragraph
nnoremap Q gqap
vnoremap Q gq

"" keep selection when indeting in visual mode
vnoremap < <gv
vnoremap > >gv
"" uniindent by s-tab
"inoremap <S-TAB> <C-O><<

"" toggle paste mode
set pastetoggle=<F12>

"" case toggling is an operator
set tildeop


" INPUT HELPS {{{1

" delimitMate -- insert pairs (like brackets) automatically {{{2
Bundle 'Raimondi/delimitMate'

"" Enable/Disable
nnoremap com :DelimitMateSwitch<CR>


" jedi.vim -- python completion and more {{{2
Bundle 'davidhalter/jedi-vim'

"" Disable autocompletion key since we use YCM
let g:jedi#completions_command = ""
"" Better use the tags-based goto
let g:jedi#goto_assignments_command = "<leader>rg"
"" ... since get_definition works alot better
let g:jedi#goto_definitions_command = "<leader>rd"
"" Show the documentation
let g:jedi#documentation_command = "<leader>rh"

"" Show everything in the same tab using windows
let g:jedi#use_tabs_not_buffers = 0

"" Neocomplete does all the hard lifting!
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0

"" Simple refactoring
let g:jedi#rename_command = "<leader>rn"
"" Show similar commands
let g:jedi#usages_command = "<leader>rs"

"" Dont show the information in the preview window
let g:jedi#show_call_signatures = "0"

"" Automatically setup vim-jedi
let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 0


" neocomplete.vim -- completion framework {{{2
if completer ==? 'neocomplete'
  "" Requires compilation
  Bundle 'Shougo/vimproc.vim'
  "" Requires lua support!
  Bundle 'Shougo/neocomplete.vim'
  "" English dictionary for neocomplete
  Bundle 'ujihisa/neco-look'

  "" enable/disable
  nnoremap coC :NeoCompleteToggle<CR>
  nnoremap [oC :NeoCompleteLock<CR>
  nnoremap ]oC :NeoCompleteUnlock<CR>

  "" launches neocomplete automatically on vim startup
  let g:neocomplete#enable_at_startup = 1
  "" neo case sensivity as long as complete-phrase is lowercase
  let g:neocomplete#enable_smart_case = 1
  "" use underscore completion
  let g:neocomplete#enable_underbar_completion = 1
  "" sets minimum char length of syntax keyword.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  "" make caching asyc using vimproc
  let g:neocomplete#use_vimproc = 1

  "" define keywords
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  "" setup omnifunctions
  let g:neocomplete#force_overwrite_completefunc = 1
  if !exists('g:neocomplete#omni_functions')
    let g:neocomplete#omni_functions = {}
  endif
  if !exists('g:neocomplete#force_omni_patterns')
    let g:neocomplete#force_omni_patterns = {}
  endif
  let g:neocomplete#force_omni_patterns.python = '[^. \t]\.\w*'
  set omnifunc=syntaxcomplete#Complete

  "" dont complete on enter
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#smart_close_popup() . "\<CR>"
  endfunction

  if snipper ==? 'ultisnips'
    inoremap <expr><S-TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  endif
endif

" neosnippet.vim -- snippets {{{2
if snipper ==? 'neosnippet'
  Bundle 'Shougo/neosnippet.vim'

  "" change snippet directory
  let g:neosnippet#snippets_directory='~/.vim/snippets'
  "" conceal jump markers
  ""if has('conceal')
  ""  set conceallevel=2 concealcursor=i
  ""endif

  "" SuperTab like snippets behavior
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  "" Expand or complete with tab, jump with <c-f>
  "imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  "smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<TAB>"
  "imap <C-F> <Plug>(neosnippet_jump)
endif

" omnicomplete navigation using j/k {{{2
function! OmniPopup(action)
  if pumvisible()
    if a:action == 'j'
      return "\<C-N>"
    elseif a:action == 'k'
      return "\<C-P>"
    endif
  else
    if a:action == 'j'
      return "\<C-J>"
    elseif a:action == 'k'
      return "\<C-K>"
    endif
  endif
  return a:action
endfunction


inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" YouCompleteMe -- autocompletion & more {{{2
if completer ==? 'ycm'
  Bundle 'Valloric/YouCompleteMe'

  "" Tab completion is run through SuperTab
  let g:ycm_key_list_select_completion = ['<S-TAB>', '<Down>']
  let g:ycm_key_list_previous_completion = ['<UP>']
  nnoremap <leader>di :YcmShowDetailedDiagnostic<CR>

  "" Also use tag file entries
  let g:ycm_collect_identifiers_from_tags_files = 1

  "" Enable autocompletion in comments
  let g:ycm_complete_in_comments = 1
  "" Keep YCM from mapping to <CR>
  inoremap <expr><CR>  pumvisible() ? "\<CR>" : "\<CR>"

  "" use global clang config file
  let g:ycm_global_ycm_extra_conf = '/home/dsuess/.vim/.ycm_extra_conf.py'
  "" always ask if it's save to run
  let g:ycm_confirm_extra_conf = 1

  "" My own tex plugin
  let g:ycm_semantic_triggers =  {
        \   'tex' : ['cite{'],
        \   'haskell': ['.']
        \ }

endif

" UltiSnips -- snippets {{{2
if snipper ==? 'ultisnips'
  Bundle 'SirVer/ultisnips'

  "" Next/Last snippet
   let g:UltiSnipsExpandTrigger="<tab>"
   let g:UltiSnipsJumpForwardTrigger="<tab>"
   let g:UltiSnipsJumpBackwardTrigger="<C-B>"

   "" set directories
   let g:UltiSnipsSnippetDirectories = ["UltiSnips"]

   "" from ftdetect/UltiSnips.vim
   autocmd FileType * call UltiSnips#FileTypeChanged()
   autocmd BufNewFile,BufRead *.snippets setf snippets
endif
"2}}}

set completeopt=menuone,longest

"" Move digraphs out of the way of autocompletion
inoremap <C-D> <C-K>

" MOTIONS {{{1

" matchit -- extended % matching {{{2
Bundle 'tmhedberg/matchit'

" vim-easymotion -- even faster vim-motions {{{2
Bundle 'Lokaltog/vim-easymotion'
"" Use , as its leader key
let g:EasyMotion_leader_key = ','

" vim-seek -- two-character motions in one line {{{2
Bundle 'goldfeld/vim-seek'
"" m/M for forward/backward search
let g:SeekKey = 'm'
let g:SeekBackKey = 'M'

" Extened Text Motions (i$, i/,...) {{{2
"" http://connermcd.com/blog/2012/10/01/extending-vim%27s-text-objects/
let pairs = { "$" : "$",
      \ ",": ",",
      \ "/": "/"}

for [key, value] in items(pairs)
  exe "nnoremap ci".key." T".key."ct".value
  exe "nnoremap ca".key." F".key."cf".value
  exe "nnoremap vi".key." T".key."vt".value
  exe "nnoremap va".key." F".key."vf".value
  exe "nnoremap di".key." T".key."dt".value
  exe "nnoremap da".key." F".key."df".value
  exe "nnoremap yi".key." T".key."yt".value
  exe "nnoremap ya".key." F".key."yf".value
endfor

"2}}}

"" Simulate US keyboard layout for brackets
map ü [
map + ]

"" Scroll through paragraphs with J/K
noremap K {
noremap J }

"" Goto Tag
noremap gt <c-]>
"" Forward/back one jump
noremap [j <c-O>
noremap ]j <c-I>

"" Define "inside <space>" motion
onoremap i<space> iW
vnoremap i<space> iW
onoremap a<space> aW
vnoremap a<space> aW

"" Goto first quickfix/location list entry
nnoremap <leader>p :cc<CR>
nnoremap <leader>P :ll<CR>

"" Escape from autocompleted brackets/quotes/etc
inoremap <c-l> <Right>

" FOLDING {{{1

" improved-paragraph-motion -- pargraph motions work well with folding {{{2
"" Dont use github repository since files contain windows-newlines
set rtp+=~/.vim/sbundle/Improved-paragraph-motion/

"" Skip all folded paragraphs
let g:ip_skipfold = 1

"2}}}

"" Use marker-folding on default
set foldmethod=marker
set foldnestmax=1

"" Folding/Unfolding using space
nnoremap <leader><space> za
vnoremap <leader><space> zf

"" opening folds on occasion
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo


" FILES & COMMANDS {{{1

"" Use bash instead of default shell
set shell=bash

"" show the keyboard command entered
set showcmd

"" sane tab completion in command mode
set wildmode=longest,list
set wildmenu

"" Sync working dir to current file
set autochdir
"" Save and open modified files automatically when necessary
set autowrite
set autoread
"" Allow switching buffers without saving
set hidden


"" No backup and swap files
set nobackup
set nowritebackup
set noswapfile


"" Save & Load view automatically
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview
set viewoptions=cursor,folds
"" Location where these view-files are saved
set viewdir=~/.vim/.view


"" Save file using s
nnoremap <silent> s :w<CR>
"" enter sudo mode by w!!
cmap w!! w !sudo tee % > /dev/null

"" Quick access and reloading of .vimrc and snippets
nnoremap <silent> <leader>sv :e $MYVIMRC<CR>
nnoremap <silent> <leader><F12> :so $MYVIMRC<CR>


" NAVIGATION & SEARCHING {{{1

" ag.vim -- advanced searching inside files {{{2
Bundle 'rking/ag.vim'

nnoremap <leader>a :Ag |" Dont strip space!

" ctrlp.vim -- file navigation, searching and much more {{{2
Bundle 'kien/ctrlp.vim'

"" Key Settings
let g:ctrlp_map = '<LEADER>e'
nnoremap <LEADER>v :CtrlPBuffer<CR>
nnoremap <LEADER>E :CtrlPMRUFiles<CR>
nnoremap <LEADER>f :CtrlPBufTag<CR>
nnoremap <LEADER>F :CtrlPBufTagAll<CR>
nnoremap <LEADER>. :CtrlPChange<CR>
nnoremap <LEADER>tt :CtrlPTag<CR>
nnoremap <LEADER>bm :CtrlPBookmarkDir<CR>
nnoremap <LEADER>u :CtrlPUndo<CR>
nnoremap <LEADER>BQ :CtrlPQuickfix<CR>
nnoremap <LEADER>g :CtrlPLine<CR>
nnoremap <LEADER>~ :CtrlPRoot<CR>

"" Disply window on bottom
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_match_window_reversed = 1
"" Ignore certain filetypes
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend|idb|so|mod|aux|fls|blg|bbl)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
"" Directory to start searching for files
let g:ctrlp_working_path_mode = 'ra'
"" Dont show hidden files
let g:ctrlp_show_hidden = 0
"" Jump to file if it is already open
let g:ctrlp_switch_buffer = 'E'
"" Speed up operations by caching
let g:ctrlp_use_caching = 0
let g:ctrlp_cache_dir = $HOME . '/.vim/.ctrlp/'

"" list LaTeX tags correctly
let tlist_tex_settings = 'latex;l:labels;s:sections;t:subsections;u:subsubsections'

" SearchComplete -- Tab completion for searching {{{2
Bundle 'vim-scripts/SearchComplete'

"2}}}

"" Goto first search hit while typing
set incsearch
"" caseinsensetive search, when searchphrase is lowercase
set smartcase
"" Highlight search result and clear with <leader>/
set hlsearch
nnoremap <silent> <leader>/ :nohlsearch<CR>

"" Always center search results (and force fold opening)
nnoremap n nzzzO
nnoremap N NzzzO

" PROJECTS & TAGS {{{1

" vim-easytags -- create tag files {{{2
"Bundle 'xolox/vim-misc'
"Bundle 'xolox/vim-easytags'

""" location of global file
"let g:easytags_file = '~/.vim/tags'
""" write into local .vimtags (if exists), otherwise global
"let g:easytags_dynamic_files = 1
""" dont update updatetime yourself
"let g:easytags_updatetime_autodisable = 0
""" create tags
"nnoremap <leader>ct :UpdateTags<CR>


" tagbar -- show tag structure in side bar {{{2
Bundle 'majutsushi/tagbar'

"" open/close similar to vim-unimpaired
nnoremap <silent> cot :TagbarToggle<CR>
nnoremap <silent> [ot :TagbarOpen<CR>
nnoremap <silent> ]ot :TagbarClose<CR>


" TagmaTasks -- TODO list manager (disabled) {{{2
"" replacement for vim-tasklist
Bundle 'LStinson/TagmaTasks'

nmap <silent> coT <Plug>TagmaTasks


" vim-fugitive -- git interface {{{2
Bundle 'tpope/vim-fugitive'

nnoremap <leader>GS :Gstatus<CR>
nnoremap <leader>GW :Gwrite<CR>
nnoremap <leader>GL :Glog<CR>
nnoremap <leader>GC :Gcommit<CR>

"" automatically delete fugitive buffers on close
autocmd BufReadPost fugitive://* set bufhidden=delete

"2}}}

"" location of tag files (use first existend one)
set tags=
" set tags=.vimtags,/home/dsuess/.vim/tags
nnoremap gT :exe "ptjump " . expand("<cword>")<CR>

"" Goto tag using enter
autocmd filetype help nnoremap <buffer> <cr> <C-]>

" BUILDING & LANGUAGE SPECIFICS {{{1


" LaTeXBox {{{2
Bundle 'LaTeX-Box-Team/LaTeX-Box'

"" Use background-contious compilation
let g:LatexBox_latexmk_options = "-pdflatex='pdflatex -synctex=1 \%O \%S'"
let g:LatexBox_latexmk_async = 1
let g:LatexBox_latexmk_preview_continuously = 1
let g:LatexBox_viewer = 'okular\ --unique'
"" Show errors in quickfix but dont loose focus
"" !! NEEDS RECENT VERSION OF LATEXMK TO WORK PROPERLY WITH CONTINOUS MODE !!
let g:LatexBox_quickfix = 2
"" TOC on the right side
let g:LatexBox_split_side = 'rightbelow'

let g:LatexBox_ignore_warnings = [
      \'Underfull',
      \'Overfull',
      \'specifier changed to',
      \'Package natbib Warning',
      \'A float is stuck',
      \'Package hyperref Warning',
      \'LaTeX Font Warning']

"u set a custom make target {{{2
function! SetMake()
  let mkprg = input('? ')
  execute 'setlocal makeprg=' . substitute(mkprg, ' ', '\\ ', 'g')
endfunction

nnoremap <leader>sm :call SetMake()<CR>


" closetag.vim -- close xml tags {{{2
Bundle 'closetag.vim'

" python-mode -- the name says it all {{{2
Bundle 'klen/python-mode'

let g:pymode_breakpoint_cmd = "import ipdb; ipdb.set_trace()  # XXX BREAKPOINT"

"" Disable all unused stuff
let g:pymode_doc = 0
let g:pymode_lint = 0
let g:pymode_folding = 0
let g:pymode_virtualenv = 0
let g:pymode_utils_whitespaces = 0
let g:pymode_indent = 0

"" Run current file
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>rr'

"" Breakpoint support
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>rb'

"" Refactoring stuff
let g:pymode_rope = 0
"" Dont clutter usefull keys -- jedi is better!
let g:pymode_rope_autocomplete_map = '<F4>aztklj'
let g:pymode_rope_autoimport_modules = ["os","shutil","datetime", "numpy", "matplotlib.pyplot"]

"" and motions
let g:pymode_motion = 1

"" Enable pymode's custom syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_print_as_function = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_syntax_string_formatting = g:pymode_syntax_all
let g:pymode_syntax_string_format = g:pymode_syntax_all
let g:pymode_syntax_string_templates = g:pymode_syntax_all
let g:pymode_syntax_doctests = g:pymode_syntax_all
let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
let g:pymode_syntax_builtin_funcs = g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator = g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator = g:pymode_syntax_all
let g:pymode_syntax_highlight_self = g:pymode_syntax_all
let g:pymode_syntax_slow_sync = 0

" MatchTagAlways -- Visual marking of HTML/XML/... tags {{{2
Bundle 'Valloric/MatchTagAlways'

" vim-dispatch -- asynchroneous building {{{2
Bundle 'tpope/vim-dispatch'

"" start a shell in a new window
nnoremap <leader>ds :Dispatch zsh<CR>
nnoremap <leader>dd :Dispatch<CR>
nnoremap <leader>dm :Make!<CR>
nnoremap <leader>DD :Dispatch!<CR>

"" shortcut to build with dispatch
map <silent> <LEADER>m :Make<CR>
map <silent> <LEADER>M :Dispatch make<CR>


" vim-fswitch -- Easily switch between header and cpp file
Bundle 'derekwyatt/vim-fswitch'

"" Switch to the file and load it into the current window >
nmap <silent> <Leader>oo :FSHere<cr>
"" Switch to the file and load it into the window on the right >
nmap <silent> <Leader>ol :FSRight<cr>
"" Switch to the file and load it into a new window split on the right >
nmap <silent> <Leader>oL :FSSplitRight<cr>
"" Switch to the file and load it into the window on the left >
nmap <silent> <Leader>oh :FSLeft<cr>
"" Switch to the file and load it into a new window split on the left >
nmap <silent> <Leader>oH :FSSplitLeft<cr>
"" Switch to the file and load it into the window above >
nmap <silent> <Leader>ok :FSAbove<cr>
"" Switch to the file and load it into a new window split above >
nmap <silent> <Leader>oK :FSSplitAbove<cr>
"" Switch to the file and load it into the window below >
nmap <silent> <Leader>oj :FSBelow<cr>
"" Switch to the file and load it into a new window split below >
nmap <silent> <Leader>oJ :FSSplitBelow<cr>

" vim-ipython -- integration with ipython kernels {{{2
Bundle 'ivanov/vim-ipython'

nnoremap <F3> :call system('ipython qtconsole --pylab inline &')<CR>

"" shortcut config in ftplugin/python.vim

" vim-sparkup -- zen coding with html/xml {{{2
Bundle 'tristen/vim-sparkup'

" vim-markup -- syntax and matching for markdown {{{2
Bundle 'plasticboy/vim-markdown'

" vim-unstack -- nice representation of stack-traces{{{2
Bundle 'mattboehm/vim-unstack'

" vim-makeshift -- switch makeprg
Bundle 'johnsyweb/vim-makeshift'
" Bundle 'dseuss/vim-makeshift'
let g:makeshift_on_startup = 1
let g:makeshift_on_bufread = 1
let g:makeshift_on_bufnewfile = 1
let g:makeshift_on_bufenter = 1
let g:makeshift_chdir = 1

" vim2hs -- Haskell for vim {{{2
Bundle 'dag/vim2hs'

" neco-ghc -- omni completion for Haskell {{{2
"" Requires ghc-mod
Bundle 'eagletmt/neco-ghc'
let g:necoghc_enable_detailed_browse = 1

"2}}}


"" Build ctags in current dir
map <silent> <leader>cT !ctags-exuberant -R -f .vimtags & <CR>

"" Dont hide anything
set concealcursor=

"" Add spell-stuff here
set spellfile=$HOME/.vim/dictionary.add


" FILETYPES {{{1

" edit the ftplugin file {{{2
function! OpenFiletypeFile()
  let path_to_file = '~/.vim/after/ftplugin/' .  &filetype . '.vim'
  exe "edit " . path_to_file
endfunction
command! EditFiletype call OpenFiletypeFile()

" and reload the thing
function! ReloadFiletypeFile()
  let path_to_file = '~/.vim/after/ftplugin/' .  &filetype . '.vim'
  exe "source " . path_to_file
endfunction
command! ReloadFiletype call ReloadFiletypeFile()

" custom filetypes {{{2
"" pyx -- cython source file
autocmd BufRead,BufNewFile *.pyx set filetype=cython
"" pyf -- f2py interface file
autocmd BufRead,BufNewFile *.pyf setf fortran
"" tikz -- drawing pictures with latex
autocmd BufRead,BufNewFile *.tikz setf tex
"" xmds -- markup file for xmds2 pde-integrator
autocmd BufRead,BufNewFile *.xmds setf xml
autocmd BufRead,BufNewFile *.xmds compiler xmds2
"" SCONS build files
autocmd BufRead,BufNewFile SConstruct set filetype=python
autocmd BufRead,BufNewFile SConscript set filetype=python

"2}}}

"" enable filetype detection
filetype plugin indent on

