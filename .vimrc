"---------------------------------------
"  Yanorei32 .vimrc
"---------------------------------------
set backspace=2

"{{{

"\
"| Tips. 
"|  ':source ~/.vimrc' to reload .vimrc
"|  ':PlugInstall' to plugin install
"/

"}}}

"---------------------------------------
" Filetype Off 
"---------------------------------------
"{{{

filetype off
filetype plugin indent off

"}}}

"---------------------------------------
" Plugin Manager
"---------------------------------------
"{{{

" check status
if has('vim_starting')
	" add runtime path
	set rtp+=~/.vim/plugged/vim-plug
	
	" install if not installed
	if !isdirectory(expand('~/.vim/plugged/vim-plug'))
		echo 'install vim-plug'

		echo 'create directory...'
		call system('mkdir -p ~/.vim/plugged/vim-plug')

		echo 'clone repo...'
		call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')

	endif
endif

"}}}

"---------------------------------------
" Plugin List
"---------------------------------------
"{{{
call plug#begin('~/.vim/plugged')

" plugin manager
Plug 'junegunn/vim-plug', { 'dir': '~/.vim/plugged/vim-plug/autoload' }

" color schemes
Plug 'w0ng/vim-hybrid'
Plug 'jacoborus/tender.vim'
Plug 'sonjapeterson/1989.vim'
Plug 'tomasr/molokai'

" Vim fugitive
Plug 'tpope/vim-fugitive'

" taboo (tab name change)
Plug 'gcmt/taboo.vim', { 'for' : 'nothing' }

" lightline.vim
Plug 'itchyny/lightline.vim'

" toggle comment
Plug 'tomtom/tcomment_vim'

" Twitter
" Plug 'basyura/bitly.vim'
" Plug 'basyura/TweetVim'
" Plug 'basyura/twibill.vim'
" Plug 'mattn/webapi-vim'
" Plug 'yomi322/neco-tweetvim'
" Plug 'yomi322/unite-tweetvim'

" Auto Close
Plug 'Townk/vim-autoclose'

" vim surround ( text -> visual select and type S' -> 'text' )
Plug 'tpope/vim-surround'

" nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'

" Emmet
Plug 'mattn/emmet-vim', { 'for': [ 'css', 'html', 'php'] }

" syntax
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'hail2u/vim-css3-syntax', { 'for': [ 'css', 'html', 'php'] }
Plug 'jelera/vim-javascript-syntax', { 'for': [ 'javascript', 'html', 'php'] }
Plug 'OrangeT/vim-csharp', { 'for' : 'cs' }
Plug 'joker1007/vim-markdown-quote-syntax', { 'for': 'markdown' }

" Tabular (:Tableformat wrap)
Plug 'godlygeek/tabular', { 'for': 'markdown' }

" vim-markdown (:Tableformat)
Plug 'rcmdnk/vim-markdown', { 'for': 'markdown' }

" Open Browser
Plug 'tyru/open-browser.vim'

" open browser not work on cygwin bug fix
if has('win32unix')
	let g:previm_open_cmd = 'cygstart '
end

" Previm (Markdown Preview)
Plug 'kannokanno/previm', { 'for': 'markdown' }

Plug 'simeji/winresizer'

Plug 'vim-scripts/gitignore.vim'

Plug 'embear/vim-localvimrc'

call plug#end()

"}}}

"---------------------------------------
" Lightline
"---------------------------------------
"{{{

" use powerline ?
" if has("unix") && $SSH_TTY == "" && !has("win32unix")
" 	let usePowerLine = 1
" 	echo "use powerline"
" else
" 	let usePowerLine = 0
" 	echo "is not powerline"
" endif



" StatusLine show
set laststatus=2

" Show Tabline
set showtabline=2

" Vim Default Status Bar Mode View
set noshowmode

" Disable taboo tabline
let g:taboo_tabline = 0

function! LightlineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'RO' : ''
	"return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
	return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
\		(&ft == 'vimfiler' ? vimfiler#get_status_string() :
\		&ft == 'unite' ? unite#get_status_string() :
\		&ft == 'vimshell' ? vimshell#get_status_string() :
\		'' != expand('%:t') ? expand('%:t') : '[No Name]') .
\		('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
		let g:a = fugitive#head()
		if g:a != ''
			return ''.fugitive#head()
"			return ' '.fugitive#head()
		else
			return 'No git'
		endif
	else
		return ''
	endif
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
	return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"let g:lightline = {
\		'colorscheme': 'wombat',
\		'mode_map': { 'c': 'NORMAL' },
\		'active': {
\			'left': [
\				[ 'mode', 'paste' ],
\				[ 'fugitive', 'filename' ]
\			]
\		},
\		'component_function': {
\			'modified':			'LightlineModified',
\			'fugitive':			'LightlineFugitive',
\			'filename':			'LightlineFilename',
\			'readonly':			'LightlineReadonly',
\			'fileformat':		'LightlineFileformat',
\			'filetype':			'LightlineFiletype',
\			'fileencoding':	'LightlineFileencoding',
\			'mode':					'LightlineMode'
\		},
\		'separator': {
\			'left': '',
\			'right': ''
\		},
\		'subseparator': {
\			'left': '',
\			'right': ''
\		}
\	}

let g:lightline = {
\		'colorscheme': 'wombat',
\		'mode_map': { 'c': 'NORMAL' },
\		'active': {
\			'left': [
\				[ 'mode', 'paste' ],
\				[ 'fugitive', 'filename' ]
\			]
\		},
\		'component_function': {
\			'modified':			'LightlineModified',
\			'fugitive':			'LightlineFugitive',
\			'filename':			'LightlineFilename',
\			'readonly':			'LightlineReadonly',
\			'fileformat':		'LightlineFileformat',
\			'filetype':			'LightlineFiletype',
\			'fileencoding':	'LightlineFileencoding',
\			'mode':					'LightlineMode'
\		}
\	}

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✓",
    \ "Unknown"   : "?"
    \ }

map <C-n> <plug>NERDTreeTabsToggle<CR>


"}}}

"---------------------------------------
" Language
"---------------------------------------
"{{{

" internal encoding
set encoding=utf-8

" terminal encoding
set termencoding=utf-8

" language set
language C

" new line format
set fileformats=unix,dos,mac

" file encodings
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,utf-16le,utf-16,default

"}}}

"---------------------------------------
" Indent
"---------------------------------------
"{{{

" indent size
set tabstop=4
set shiftwidth=4

" set tabsize 2 if html or ruby or vimrc
autocmd FileType html,ruby,vim set tabstop=2
autocmd FileType html,ruby,vim set shiftwidth=2
autocmd FileType cs set tabstop=4
autocmd FileType cs set shiftwidth=4

" smart
set autoindent
set smartindent

" new line auto comment function disable
autocmd FileType * setlocal formatoptions-=ro

"}}}

"---------------------------------------
" Basic
"---------------------------------------
"{{{

" No Compatible Mode
set nocompatible

"}}}

"---------------------------------------
" Syntax
"---------------------------------------
"{{{

" set syntax
syntax on

" show number
set number

" highlight cursor line
set cursorline

" no wrap
set nowrap

" 256 colors
set t_Co=256

" title bar
set title

" background color
set background=dark

" show hidden charactor
set list
set listchars=tab:>\ ,trail:-,eol:¬,extends:»,precedes:«

" add html match pair
autocmd FileType html set matchpairs& matchpairs+=<:>

"-------------------
" hybrid
"--------------------
"{{{

" Set color scheme
colorscheme hybrid 

" Reduced Contrust
let g:hybrid_reduced_contrast = 1

"}}}
"-------------------
" 1989
"--------------------
"{{{

" Set color scheme
"colorscheme 1989

"}}}
"-------------------
" molokai
"--------------------
"{{{

" Set color scheme
" colorscheme molokai

"}}}
"-------------------
" tender
"-------------------
"{{{

" colorscheme
" colorscheme tender

"}}}

"}}}

"---------------------------------------
" Search
"---------------------------------------
"{{{

" inc search
set incsearch

" enable highlight search
set hlsearch

" search word display center
nmap n nzz
nmap N Nzz

" clear highlight after ctrl-l
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

"}}}

"---------------------------------------
" Tab Short cut
"---------------------------------------
"{{{

" set [Tag] key
nnoremap [Tag] <Nop>
nmap t [Tag]

" change tab shortcut <t-N>
for n in range(1,9)
	execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor

" tab create
nnoremap <silent> [Tag]c :tabnew<CR>

" tab close
nnoremap <silent> [Tag]x :tabclose<CR>

" tab next
nnoremap <silent> [Tag]n :tabnext<CR>

" tab previous
nnoremap <silent> [Tag]p :tabprevious<CR>


"}}}

"---------------------------------------
" Other
"---------------------------------------
"{{{

" visual mode <ESC> very slow fix
set timeoutlen=1000 ttimeoutlen=0

" Don't break select after ctrl-a and ctrl-x
vnoremap <c-a> <c-a>gv
vnoremap <c-x> <c-x>gv

" No autoclose '`' if markdown
autocmd FileType markdown let b:AutoClosePairs = AutoClose#DefaultPairsModified("","`")

" CPP PATH
autocmd FileType cpp setlocal path=.,/usr/include/c++/6/


autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

autocmd BufRead,BufNewFile *.py nnoremap <C-b> :w<CR>:!python %<CR>
"}}}

"---------------------------------------
" Filetype On
"---------------------------------------
"{{{

filetype plugin indent on
filetype on

"}}}


