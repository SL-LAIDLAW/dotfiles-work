" set file encoding to avoid listchar errors in linux
scriptencoding utf-8
set encoding=utf-8

" Plugin Management
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'mhinz/vim-startify' " starter page with links to recent files

" themes
Plugin 'tyrannicaltoucan/vim-deep-space' " truecolor theme
Plugin 'chriskempson/base16-vim' " 256 color theme
Plugin 'reedes/vim-colors-pencil' "vim pencil theme
Plugin 'sonph/onehalf', {'rtp': 'vim/'}
Plugin 'nanotech/jellybeans.vim'
Plugin 'ryanoasis/vim-devicons' " icons in nerdtree and starterpage

" writing
Plugin 'ferrine/md-img-paste.vim' " allows <leader>p to paste an image into vim
Plugin 'reedes/vim-pencil' "IA writer like environment for non-code writing

Plugin 'preservim/nerdtree'
Plugin 'scrooloose/nerdcommenter' " keyboard shorcut for easy comments
Plugin 'tpope/vim-fugitive'	" git in vim
Plugin 'neworld/vim-git-hunk-editor'
Plugin 'kshenoy/vim-signature' " show marks in sidebar

" Nvim-R
Plugin 'jalvesaq/Nvim-R'

" Easymotion
" press ,<leader><leader> then a movement key to show hints to move cursor
Plugin 'easymotion/vim-easymotion' " press <leader><leader> to
" Tmux interaction
Plugin 'benmills/vimux'

" Autocompletion
if has('nvim')
  Plugin 'Shougo/deoplete.nvim'
else  " these allow deoplete to work with vim8
  Plugin 'Shougo/deoplete.nvim'
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif

" machine-learning based tool for autocompletion
Plugin 'tbodt/deoplete-tabnine'
" download TabNine binaries if not present
if !isdirectory("~/.vim/bundle/deoplete-tabnine/binaries")
    call system("bash ~/.vim/bundle/deoplete-tabnine/install.sh")
endif


" Snippet support for deoplete
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'

" Autorun line by line and show result
Plugin 'metakirby5/codi.vim'

" linter
Plugin 'w0rp/ale'

Plugin 'darfink/vim-plist'

" underline letters to seek to
Plugin 'unblevable/quick-scope'

" color code highlighter
Plugin 'lilydjwg/colorizer'

" <leader>gu to show undo/redo history tree
Plugin 'sjl/gundo.vim'
"run ;td or :TaskList to show all todos
Plugin 'vim-scripts/TaskList.vim'

" minimalist writing experience
Plugin 'junegunn/goyo.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" allow plugin and syntax again
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""
"         APPEARANCE          "
"""""""""""""""""""""""""""""""
syntax on
set background=dark

set list	" show invisible characters
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" don't show statusbar or commandline
set laststatus=0
set noshowmode


colorscheme jellybeans
if has('nvim')
	" Fix terminal colors
	set t_Co=256
	colorscheme jellybeans " set base16 colorscheme incase no truecolor support
endif

if !empty($COLORTERM)
	" For Neovim 0.1.3 and 0.1.4
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1

	" for vim 8 / Or if you have Neovim >= 0.1.5
	if (has("termguicolors"))
		set termguicolors
		colorscheme deep-space

		" colorscheme specific settings
		let g:deepspace_italics=1
	endif

endif

" Correct RGB escape codes for vim inside tmux
if !has('nvim') && $TERM ==# 'screen-256color'
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set t_Co=88
endif


"""""""""""""""""""""""""""""""
"           GENERAL           "
"""""""""""""""""""""""""""""""
set relativenumber number	" Show line numbers
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
set matchpairs+=<:> "add <> as a matchpair as its not included by default

" Search within search if visual selection
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
set wrapscan	" Searches wrap around end of file
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>


" Set leader to be ',' as '/' is hard to reach on EU keyboards
let mapleader=","

set mouse=i	" Allow mouse in insert mode
set autoindent	" Auto-indent new lines
set smarttab	" Enable smart-tabs
set shiftround " round indent to a multiple of 'shiftwidth'
set noexpandtab		" use tabs not spaces
" for tabs to work these need to be the same
set shiftwidth=4	" Number of auto-indent spaces
set tabstop=4	" Number of spaces per Tab

set autochdir	" Change working directory to open buffer

"set vim buffer to clipboard
set clipboard=unnamed
set backspace=indent,eol,start	" Backspace behaviour

" don't redraw while executing macros (better performance)
set lazyredraw

" No annoying sound on errors
set noerrorbells
set novisualbell

" escape key is hard to reach
inoremap jk <Esc>
inoremap kj <Esc>

" Replace all is aliased to S.
nmap S :%s//g<Left><Left>
vmap S :s//g<Left><Left>

" Opposite of J to split lines
map K r<Enter>

" Replace word under cursor with clipboard
map <leader>cw ve"0px

" press gm to go to mark (` is hard to press on my keyboard)
nmap gm `

" TAB and Shift-TAB in normal mode cycle buffers
nmap <Tab> :bn<CR>
nmap <S-Tab> :bp<CR>

" close buffer on ZZ not all of vim (unless only one buffer)
nmap ZZ :call CloseBuffer()<cr>
function! CloseBuffer()
  let num_buffers = len(getbufinfo({'buflisted':1}))
  if (num_buffers == 1)
	  x
  else
	  w|bd
  endif
endfunction



" allow indenting of code blocks without losing selection each time
vnoremap < <gv
vnoremap > >gv

" how many lines of history vim should keep
set hidden
set history=10000

" Turn persistent undo on , so can undo even when you close a buffer
if !isdirectory($HOME."/.vim")
	call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim-undo-dir")
	call mkdir($HOME."/.vim-undo-dir", "", 0700)
endif
set undodir=~/.vim-undo-dir
set undofile
set undolevels=10000

" Always use vertical diffs
set diffopt+=vertical

" Folding
set foldenable " enable folding
set foldmethod=manual
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold Max

" space open/closes folds
nnoremap <space> za

" save session : saves windows and locations. Reopen with "nvim -S"
nnoremap <leader>s :mksession<CR>

" get out of neovim :terminal using Esc
tnoremap <Esc> <C-\><C-n>

" save folds
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" Fast saving
nmap <leader>w :w!<cr>

" disable Ex mode
nnoremap Q <Nop>

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" enter vim at same place you left
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""
"      SPELL CHECK            "
"""""""""""""""""""""""""""""""
map <F6> :setlocal spell! spelllang=en_gb<CR>
map <F7> :setlocal spell! spelllang=fr<CR>
" Cntrl-l sets the first suggested spelling for the incorrect word that is
" next after the cursor, but can be undone by pressing <Esc>u
imap <c-l> <c-g>u<Esc>]s1z=`]a<c-g>u
" Cntrl-b is easier to reach than esc-u
imap <c-b> <Esc>uei
" zg adds word as "good word" in spell file
" zw adds word as "wrong word" in spell file


"""""""""""""""""""""""""""""""
"      SURROUND WORDS         "
"""""""""""""""""""""""""""""""
" ," Surround a word with "quotes"
map <leader>" ysiw"
vmap <leader>" c"<C-R>""<ESC>

" <leader>' Surround a word with 'single quotes'
map <leader>' ysiw'
vmap <leader>' c'<C-R>"'<ESC>
" <leader>) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map <leader>( ysiw(
map <leader>) ysiw)
vmap <leader>) c( <C-R>" )<ESC>
vmap <leader>( c(<C-R>")<ESC>

" <leader>[ Surround a word with [brackets]
map <leader>] ysiw]
map <leader>[ ysiw[
vmap <leader>[ c[ <C-R>" ]<ESC>
vmap <leader>] c[<C-R>"]<ESC>

" <leader>{ Surround a word with {braces}
map <leader>} ysiw}
map <leader>{ ysiw{
vmap <leader>} c{ <C-R>" }<ESC>
vmap <leader>{ c{<C-R>"}<ESC>

map <leader>` ysiw`
map <leader>_ ysiw_


""""""""""""""""""""""""""""""
"    WINDOWS MANAGEMENT
""""""""""""""""""""""""""""""

" These move to the window in the direction chosen
" if it doesn't exist then it makes a split there
map <C-h> :call WinMove('h')<cr>
map <C-j> :call WinMove('j')<cr>
map <C-k> :call WinMove('k')<cr>
map <C-l> :call WinMove('l')<cr>

" Window movement shortcuts
" move to the window in the direction shown, or create a new window
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction


" Navigating with guides
inoremap <leader><Tab> <Esc>/<++><Enter>"_c4l

" File shortcuts
" Open my bibliography file in split
nnoremap <leader>eb :vsp<space>$QUTE_BIB_FILEPATH<bar>set syntax=bib<CR>

" Open my bash snippets in split
nnoremap<leader>esn :vsp<space>$dotfiles/vim/snippets/sh.snippets<CR>

" Open my vimrc in split
nnoremap<leader>evv :vsp<space>~/.vimrc<CR>

" source .vimrc
nnoremap <leader>zz :source ~/.vimrc<cr>


" insert template text on creating new some filetypes
augroup Shebang
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python3\<nl># -*- coding: utf-8 -*-\<nl>\"|$
	autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\"|$
	autocmd BufNewFile *.r 0put =\"#!/usr/bin/env Rscript\<nl>\"|$
	autocmd BufNewFile *.tex 0put =\"%&plain\<nl>\"|$

	" for new marp.md file: auto read template and start marp server in template directory
	autocmd BufNewFile *.marp.md r ~/Templates/marp/template.marp.md | w| !marp --server --preview --config-file ~/Templates/marp/marp.config.js "$(greadlink -f "$(dirname %)")" &
	autocmd BufRead *.marp.md !marp --server --preview --config-file ~/Templates/marp/marp.config.js "$(greadlink -f "$(dirname %)")" &

	" for new Rmd file: auto copy citation style to directory
	"read template into buffer, and hard link Qutebrowser bibliography to current folder
	autocmd BufNewFile *.Rmd r ~/Templates/Rmarkdown/university_paper.Rmd |!cp ~/Templates/Rmarkdown/sll-citation-style.csl "$(greadlink -f $(dirname %))"; ln ~/.qutebrowser_bibliography mybibliography.bib
	autocmd BufNewFile *.cpp r ~/Templates/cpp/basic_cpp_template.cpp
	autocmd BufNewFile *.beamer r ~/Templates/Rmarkdown/red_cambridgeus.beamer
	autocmd BufNewFile *.\(cc\|hh\) 0put =\"//\<nl>// \".expand(\"<afile>:t\").\" -- \<nl>//\<nl>\"|2|start!
augroup END


" insert template text on creating new some filetypes
augroup FiletypeMacros
	autocmd FileType python nnoremap <C-P> vEyopa)0iprint(0
	autocmd FileType python nnoremap <C-m> vEy0Pa = 0
	autocmd FileType sh nnoremap <C-P> veyopa"0iecho "$0
augroup END

""""""""""""""""""""""""""""""
"     PLUGIN SETTINGS        "
""""""""""""""""""""""""""""""
" Fugitive Plugin Settings
nmap <silent> <leader>gs :Gstatus<cr>
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gd :Gdiff<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>
nmap <silent><leader>gc :Gcommit<cr>
vnoremap <silent><leader>g- :'<,'>diffput<cr>
vnoremap <silent><leader>g= :'<,'>diffget<cr>

" vim-git-hunk-editor settings
nnoremap <F11> :HunkLineToggle<cr>

" gundo (revision of history saving)
map <leader>gu :GundoToggle<CR>
let g:gundo_width = 30
let g:gundo_preview_height = 15
let g:gundo_right = 1
" vim with python2 can break python3 support
if has('python3')
    let g:gundo_prefer_python3 = 1
endif

" tasklist
map <leader>td <Plug>TaskList

" NerdCommenter settings
let g:NERDCustomDelimiters = {
	\ 'rmd' : { 'left': '<!-- ','right': ' -->' },
	\ 'beamer' : { 'left': '<!-- ','right': ' -->' }
	\ }

" ALE Settings
nnoremap <F8> :ALEToggle<CR>
inoremap <F8> <esc>:ALEToggle<CR>a
" Set flake8 as python linter and autopep8 as python fixer
let g:ale_fixers = {'python': ['autopep8']}
let g:ale_linters = {'python': ['flake8']}

" Goyo
let g:pencilgoyo_status=0
nnoremap <F10> :call PencilGoyo()<CR>
function! PencilGoyo()
	if g:pencilgoyo_status == 0
		set wrap nolinebreak nolist
		set background=light
		colorscheme pencil
		:PencilSoft
		:Goyo
		let g:pencilgoyo_status=1
	else
		:Goyo
		:PencilOff
		set background=dark
		colorscheme base16-eighties
		set list linebreak
		let g:pencilgoyo_status=0
	endif
endfunction

" vim markdown <leader>p to paste img on clipboard
nmap <silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

" Nvim-R settings
let maplocalleader = ','
command! RStart let oldft=&ft | set ft=r | exe 'set ft='.oldft | let b:IsInRCode = function("DefaultIsInRCode") | normal <LocalLeader>rf
if &diff
else
	au BufReadPost,BufNewFile *.r,*.R,*.Rmd normal ,rf
endif

nmap <Space> <Plug>RDSendLine
vmap <Space> <Plug>RDSendSelection
nmap <LocalLeader>cl <Plug>RClearAll
nmap <LocalLeader>ll <Plug>RNLeftPart



" deoplete Settings
if has('nvim')
	let g:deoplete#enable_at_startup = 1

	" Enable snipMate compatibility feature.
	let g:neosnippet#enable_snipmate_compatibility = 1

	" tell neosnippet snippet directory and symlink r snippets to rstudio dir
	if !filereadable('~/.R/snippets')
		call system("ln $dotfiles/vim/snippets/r.snippets $HOME/.R/snippets")
	endif
	let g:neosnippet#snippets_directory="$dotfiles/vim/snippets"


	" use tab to expand current suggestion or suggested snippet
	imap <expr><TAB>
		\ neosnippet#expandable_or_jumpable() ?
		\    "\<Plug>(neosnippet_expand_or_jump)" :
			\ 	  pumvisible() ? "\<C-n>" : "\<TAB>"

endif

let g:codi#interpreters = {
	\ 'python': {
		\ 'bin': 'python3',
		\ 'prompt': '^\(>>>\|\.\.\.\) ',
		\ },
	\ }
