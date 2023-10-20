" if (has("termguicolors"))
"  set termguicolors
" endif

syntax on
set modelines=0

" remap
let mapleader = ","
" remap movement key hjkl to ijkl and i to h
noremap j h
noremap h i
noremap H I
" remap k => j, i => k. gj/gk on normal movement, j/k when used with a count, like d22k
noremap <silent> <expr> k (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> i (v:count == 0 ? 'gk' : 'k')
noremap <silent> <expr> <Down> (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> <Up> (v:count == 0 ? 'gk' : 'k')
" 5 down/up unless used with a count, in this case standard behavior
noremap <silent> <expr> K (v:count == 0 ? '5gj' : 'j')
noremap <silent> <expr> I (v:count == 0 ? '5gk' : 'k')
noremap <C-h> J
noremap M K
noremap J :tabprevious<cr>
noremap L :tabnext<cr>
noremap Z z<cr>
noremap <leader>d "_d
noremap D dd
noremap X "_d
noremap x "_x
noremap c "_c
noremap s "_s
nnoremap > >>
nnoremap < <<
noremap Y yy
" easier line movement
nnoremap <space>j ^
nnoremap <space>l $
" remap for operator-pending
onoremap <space>j ^
onoremap <space>l $
" prevent accidental :q
nnoremap <leader>q q:
"
" no magic search
noremap / /\V
nmap ? ?\V
noremap <C-n> *Ncgn
" switch ' with ` as it's easier to type
noremap ` '
noremap ' `
" allow macro in visual mode
xnoremap @ :normal @
" paste without copy in visual mode
xnoremap p "_dP
vnoremap > >gv
vnoremap < <gv
" prevent plugin break when C-c
noremap <C-c> <Esc>

nnoremap <silent> & :call Mana_nerdtabs()<cr>
nnoremap ² :TagbarToggle<cr>
nnoremap <leader>a :silent !git add .<cr>
nnoremap <leader>z :Git commit<cr>
nnoremap <leader>e :Git push<cr>
nnoremap <silent> <F1> :call Toggle_quick_fix()<cr>
nnoremap <F2> :MundoToggle<cr>
nnoremap gs :Gvdiffsplit<cr>
nnoremap g<F2> :Gvdiffsplit HEAD~1<cr>
nnoremap g<F3> :Gvdiffsplit HEAD~
nnoremap gh :%!hexdump -C<cr>
nnoremap <F3> :set relativenumber!<cr>
nnoremap <F8> :set fileencoding=utf8<cr>:set ff=unix<cr>
" nmap <F10> :source ~/.vimrc<cr>:AirlineRefresh<cr>
nnoremap <F12> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" move between windows
" <C-i> = <Tab>
nnoremap <C-i> <C-w>k
nnoremap <C-j> <C-w>h
nnoremap <C-k> <C-w>j
nnoremap <C-l> <C-w>l

" :terminal remap
if has("nvim")
	tnoremap <C-j> <C-\><C-n><C-w>h
	tnoremap <C-l> <C-\><C-n><C-w>l
	tnoremap <esc><esc> <C-\><C-n>
endif

noremap <C-x>k :vnew<cr>
noremap <C-x><C-k> :vnew<cr>
noremap <C-x>t :tabnew<cr>
noremap <leader>k :tabnew<cr>
noremap <C-x> <C-w>
noremap <C-A-j> :tabmove -1<cr>
noremap <C-A-l> :tabmove +1<cr>

" remap to move out and in
noremap <A-j> <C-o>
noremap <A-l> <C-i>

set tabstop=3
set shiftwidth=3
set softtabstop=3
set number
set relativenumber
"set cursorline
set lazyredraw
set ruler
set cindent
set wrap
set linebreak
set noerrorbells
set novisualbell
" hide current mode below status line
set noshowmode
set ignorecase
set smartcase
set gdefault
set nobackup
set noswapfile
set autoread
set matchpairs+=<:>
"set hidden

" ssh connection
if ($SSH_CONNECTION)
	set mouse=""
else
	set mouse=a
	set clipboard+=unnamedplus
endif

filetype plugin indent on

" autocmd for filetypes, helps to reduce remaps
autocmd Filetype conf setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=3 sts=3 sw=3
autocmd BufNewFile,BufRead *.token setlocal expandtab ts=2 sts=2 sw=2 syntax=yaml
autocmd Filetype text setlocal nocindent
autocmd Filetype c,cpp,make,idlang call s:cpp_map()
autocmd Filetype php call s:php_map()
" remove empty trailing spaces
autocmd BufWritePre * %s/\s\+$//e
" terminal insert on focus
autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
" nerd
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" autocmd TabEnter * call Mana_nerdtabs()
autocmd BufWinEnter * silent! NERDTreeMirror

nnoremap <leader>" :%s/"//<cr>
nnoremap <leader>' :setfiletype sql<cr>

function! s:cpp_map()
	nnoremap <F4> :YcmCompleter GoTo<cr>
	nnoremap <F5> :wa<cr>:Neomake! make<cr>:echon ''<cr>
	nnoremap g<F5> :wa<cr>:make -j6<cr>
	nnoremap <silent> <F6> :silent !./run.sh<cr>
	nnoremap <F7> :YcmCompleter FixIt<cr>
	nnoremap <F9> :!qmake *.pro -r -spec linux-g++<cr>
	nnoremap gd :YcmCompleter GoTo<cr>
endfunction

function! s:php_map()
	" set omnifunc=phpcomplete#CompletePHP
	" php syntax check
	nmap gp :!php -l %:p<cr>
endfunction

" colorscheme mana

set background=dark
hi clear
hi clear Normal
hi Identifier		ctermfg=116							cterm=none
hi comment			ctermfg=110
hi Constant			ctermfg=43
hi statement		ctermfg=116
hi special			ctermfg=81
hi String			ctermfg=43
hi Number			ctermfg=43
hi Character		ctermfg=43
hi Boolean			ctermfg=43
hi Float				ctermfg=43
hi Search			ctermfg=none	ctermbg=none	cterm=none
hi IncSearch												cterm=none
hi Title				ctermfg=37		ctermbg=none	cterm=none
hi	DiffChange		ctermfg=98		ctermbg=none	cterm=none
hi	DiffAdd			ctermfg=34		ctermbg=none	cterm=none
hi	DiffDelete		ctermfg=9		ctermbg=none	cterm=none
hi	DiffText			ctermfg=43		ctermbg=none	cterm=none
hi Folded			ctermfg=37		ctermbg=none	cterm=none
hi FoldColumn		ctermfg=37		ctermbg=none	cterm=none
hi CursorLine												cterm=none
hi CursorLineNR	ctermfg=116		ctermbg=24
hi WildMenu			ctermfg=116		ctermbg=23
hi VertSplit		ctermfg=24		ctermbg=none	cterm=none
hi Visual								ctermbg=none	cterm=underline
hi ErrorMsg			ctermfg=75		ctermbg=none
hi Error				ctermfg=31		ctermbg=none
hi Todo				ctermfg=24		ctermbg=none
hi SpellBad			ctermfg=169		ctermbg=none	guisp=fg
hi SpellCap			ctermfg=169		ctermbg=none	guisp=fg
hi SignColumn		ctermfg=31		ctermbg=none
hi LineNr			ctermfg=31
hi EndofBuffer		ctermfg=31		ctermbg=none
hi StatusLine		ctermfg=37		ctermbg=none	cterm=none
hi StatusLineNC	ctermfg=31		ctermbg=none	cterm=none
hi Pmenu				ctermfg=81		ctermbg=233
hi PmenuSel			ctermfg=81		ctermbg=236
hi PmenuSbar							ctermbg=0
hi PmenuThumb							ctermbg=24
hi TabLineFill												cterm=none
hi TabLine			ctermfg=31		ctermbg=none	cterm=none
hi TabLineSel		ctermfg=110		ctermbg=24		cterm=none
hi MatchParen		ctermfg=81		ctermbg=0		cterm=none

hi link phpParent				Normal
hi link PhpVarSelector		Special
hi link PhpIdentifier		Special

hi NERDTreeOpenable	ctermfg=31	ctermbg=none
hi NERDTreeClosable	ctermfg=31	ctermbg=none
hi link NERDTreeFlags		NerdTreeDir

hi SignatureMarkText					ctermfg=116		cterm=none
hi NeomakeVirtualtextWarning		ctermfg=169		cterm=none

" plugins
if (glob("~/.config/nvim/init.vim") != "")
let hostname = substitute(system('hostname'), '\n', '', '')

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline-themes'
Plug 'kshenoy/vim-signature' " for marks on the side
Plug 'simnalamburt/vim-mundo'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

if hostname == 'nuts'
	Plug 'Valloric/YouCompleteMe', { 'for': ['c', 'cpp', 'javascript', 'rust'], 'frozen': '0' }
	Plug 'neomake/neomake', { 'for': ['c', 'cpp'] }
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'
	Plug 'ryanoasis/vim-devicons'
	Plug 'sirver/ultisnips'
endif

call plug#end()

" tags
nnoremap <leader>t :silent !ctags -R --fields=+l .<cr>

" plugin YCM
let local_ycm = getcwd() . '/ycm.py'
if (filereadable(local_ycm))
	let g:ycm_global_ycm_extra_conf =  local_ycm
else
	let g:ycm_global_ycm_extra_conf =  '~/.config/nvim/ycm_extra_conf.py'
endif
let g:ycm_auto_trigger = 1
let g:ycm_warning_symbol = '▸'
let g:ycm_error_symbol = '▸'
let g:ycm_collect_identifiers_from_tags_files = 1
" set completeopt+=popup,preview
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1
" nmap <leader>v <Plug>(YCMFindSymbolInWorkspace)
" nmap <leader>f <Plug>(YCMFindSymbolInWorkspace)

" plugin phpcomplete
let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_cache_taglists = 1
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_mappings = { 'jump_to_def': '<F4>', }

" plugin ultisnips
set runtimepath+=/dalaran/arch/nvim/snippets
if (filereadable('/dalaran/arch/nvim/source/vim_snippets.vim'))
	source /dalaran/arch/nvim/source/vim_snippets.vim
endif
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
" pseudo snippets
nnoremap <leader>c f;s<cr>{<cr>}<esc>ko
nnoremap <leader>; a[]<Left>
nnoremap <leader>x o{<esc>o}<esc>O
nnoremap <leader>: :%s/\(.*\):\([^ ].*\)/\1: \2/<cr>

" plugin neomake
let g:neomake_cpp_enabled_makers = ['clang']
let g:neomake_cpp_clang_args = ['-Wall', '-Wextra', '-Wno-sign-conversion', '-x', 'c++', '-std=c++11', '-Wno-sign-compare', '-I', '/dalaran/mana/mana', '-I', '.']
let g:neomake_make_maker = { 'exe': 'make', 'args': ['-j4'], 'errorformat': '%f:%l:%c: %m' }
let g:neomake_open_list = 2
let g:neomake_place_signs = 0

" plugin nerdtree
let g:NERDTreeMapOpenSplit = 'h'
let g:NERDTreeMapToggleFilters = 'a'	" change i -> a
let g:NERDTreeMapJumpLastChild = ''		" remove J map
let g:NERDTreeMapJumpNextSibling = ''  " remote <C-j> map
let g:NERDTreeMapJumpPrevSibling = ''  " remote <C-k> map
let g:NERDTreeMinimalUI = 1
let NERDTreeMinimalMenu = 1
let g:NERDTreeBookmarksFile = '/dalaran/arch/nvim/nerdtreebookmarks'

" plugin devicons

let g:webdevicons_enable_airline_statusline = 0

" ctrlp
let g:ctrlp_prompt_mappings =
\ {
\ 'PrtSelectMove("j")':		['<C-k>', '<down>'],
\ 'PrtSelectMove("k")':		['<C-i>', '<up>'],
\ 'AcceptSelection("t")':	['<C-l>', '<A-cr>'],
\ 'PrtCurRight()':			['<right>']
\ }
let g:ctrlp_working_path_mode = 0
nnoremap <leader>l :tabnew<cr>:CtrlP<cr>
nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>l :tabnew<cr>:CtrlP<cr>
nnoremap <space>p :CtrlP<cr>

" gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
nmap <F11> :GitGutterLineHighlightsToggle<cr>
hi GitGutterAdd				ctermfg=2	ctermbg=none	cterm=none
hi GitGutterChange			ctermfg=98	ctermbg=none	cterm=none
hi GitGutterChangeDelete	ctermfg=98	ctermbg=none	cterm=none
hi GitGutterDelete			ctermfg=9	ctermbg=none	cterm=none
hi GitGutterDelete			ctermfg=9	ctermbg=none	cterm=none

" plugin tagbar
let g:tagbar_map_togglecaseinsensitive = ''
let g:tagbar_compact = 1
hi link TagbarAccessPublic GitGutterAdd
hi link TagbarAccessProtected GitGutterChange
hi link TagbarAccessPrivate GitGutterDelete

" plugin mundo
let g:mundo_map_move_newer = 'i'
let g:mundo_map_move_older = 'k'

" airline
if hostname == 'talos' || hostname == 'dalaran'
	let g:airline_powerline_fonts = 1
endif
let g:airline_theme='mana_airline'
let g:airline_skip_empty_sections = 1
let g:airline_exclude_preview = 1
let g:airline_detect_modified=1
let g:airline_detect_paste=0
let g:airline_detect_crypt=0
let g:airline_detect_spell=0
let g:airline_detect_spelllang=0
let g:airline_detect_iminsert=0
let g:airline_inactive_collapse=1
let g:airline#extensions#searchcount#enabled = 0
let g:airline#extensions#ctrlp#color_template = 'normal'
let g:airline#extensions#wordcount#enabled = 0
let g:airline_mode_map = { '__':'-', 'n':'N', 'i':'I', 'ic':'I', 'ix':'I', 'R':'R', 'c':'C', 'v':'V', 'V':'V', '':'V', 's':'S', 'S':'S', '':'S', 't':'T', }

let g:airline_section_a = '%{airline#util#wrap(airline#parts#mode(),0)}'
if hostname == 'talos' || hostname == 'dalaran'
	let g:airline_section_b = '%{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)}%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'
	let g:airline_section_c = '%<%<%{airline#extensions#fugitiveline#bufname()}%m %{Mana_neomake_status()} %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
else
	let g:airline_section_b = ''
	let g:airline_section_c = '%t'
endif
let g:airline_section_x = '%{airline#util#wrap(airline#extensions#tagbar#currenttag(),0)}'
let g:airline_section_y = '%{airline#util#wrap(airline#parts#ffenc(),0)}'
let g:airline_section_z = '%3p%% ☰%4l/%L %4v'

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''

" mana custom functions

function! Mana_nerdtabs()
	NERDTreeToggle
	execute "normal! \<C-W>w"
endfunction

function! Mana_neomake_status()
	if !exists(':Neomake') | return '' | endif
	if empty(neomake#GetJobs()) | return '' | else | return '[]' | endif
endfunction

function! Toggle_quick_fix()
	for i in range(1, winnr('$'))
		let bnum = winbufnr(i)
		if getbufvar(bnum, '&buftype') == 'quickfix'
			cclose
			return
		endif
	endfor

	copen
endfunction
endif

function! Tabline()
	let s = ''
	for i in range(tabpagenr('$'))
		let tab = i + 1
		let buflist = tabpagebuflist(tab)
		let bufignore = ['nerdtree', 'tagbar', 'codi', 'help']
		for b in buflist
			let buftype = getbufvar(b, "&filetype")
			if index(bufignore, buftype) == -1 " index returns -1 if the item is not contained in the list
				let bufnr = b
				break
			elseif b == buflist[-1]
				let bufnr = b
			endif
		endfor
		let bufname = bufname(bufnr)
		let bufmodified = getbufvar(bufnr, "&mod")
		let s .= '%' . tab . 'T'
		let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
		if bufmodified
			let s .= ' +'
		endif
		let s .= ' ' . (bufname != '' ? pathshorten(fnamemodify(bufname, ':p:~:.')) : '[No Name]') . ' '
	endfor
	let s .= '%#TabLineFill#'
	close X button
	let s .= '%#TabLine#%=%999XX'
	return s
endfunction
set tabline=%!Tabline()
