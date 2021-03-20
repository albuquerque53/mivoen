"    )         )            (       *
" ( /(      ( /(            )\ )  (  ` 
" )\()) (   )\())   (   (  (()/(  )\))(
"((_)\  )\ ((_)\    )\  )\  /(_))((_)()\ 
" _((_)((_)  ((_)  ((_)((_)(_))  (_()((_)
"| \| || __|/ _ \  \ \ / / |_ _| |  \/  |	author: Gabriel Albuquerque
"| .` || _|| (_) |  \ V /   | |  | |\/| | 	role: Developer
"|_|\_||___|\___/    \_/   |___| |_|  |_|	date: 03-2021


" =-=-=-=-=-=-=-=-=-=-=-=-=-=
"
" Plugins
" 
" =-=-=-=-=-=-=-=-=-=-=-=-=-=

call 	        plug#begin()

"Gitgutter
Plug            'airblade/vim-gitgutter'

"CtrlP (finder)
Plug            'ctrlpvim/ctrlp.vim'

"Vim Powerline (and themes)
Plug 	        'vim-airline/vim-airline'
Plug 	        'vim-airline/vim-airline-themes'

"OneDark theme
Plug            'joshdick/onedark.vim'

"Dracula theme
Plug            'dracula/vim'

"Multiple cursors
Plug            'mg979/vim-visual-multi'

"Emmet HTML
Plug            'mattn/emmet-vim'

"Typescript syntax
Plug            'HerringtonDarkholme/yats.vim'

"Coc nvim
Plug            'neoclide/coc.nvim', {'branch': 'release'}

call 	        plug#end()


" =-=-=-=-=-=-=-=-=-=-=-=-=-=
"
" Visual settings
" 
" =-=-=-=-=-=-=-=-=-=-=-=-=-=

" OneDark Theme
"set             termguicolors
"set             background=dark
"syntax          on
"colorscheme     onedark
"let             g:airline_theme = 'onedark'

" Dracula theme
set             termguicolors
syntax          on
color           dracula
let             g:airline_theme = "dracula"


" =-=-=-=-=-=-=-=-=-=-=-=-=-=
"
" Editor settings
" 
" =-=-=-=-=-=-=-=-=-=-=-=-=-=

set 		cursorline
set 		hidden
set 		number
set 		relativenumber
set 		inccommand=split
let 		g:airline_powerline_fonts=1
set 		modifiable
set             tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Keybinds/Macros config
let 		mapleader="\\"
nnoremap 	<leader>ev :vsplit ~/.config/nvim/init.vim<cr>
nnoremap 	<leader>ef :edit ~/.config/nvim/init.vim<cr>
nnoremap 	<leader>es :source ~/.config/nvim/init.vim<cr>
nnoremap 	<leader><space> :nohlsearch<cr>
imap            <leader>ll <esc>$i<right>
imap            <leader>hh <esc>0i
imap            <leader><CR> <esc>$i<right><CR>
nnoremap        <leader>; <esc>$i<right>;<ESC>
vmap            <leader>d "_di
nno             yyd yyP<down>
nno             ccp I//<ESC> $
nno             ccp I// <ESC> $
let             g:user_emmet_leader_key=','
set             clipboard+=unnamedplus
nnoremap        d "_d
nnoremap        xx dd
xnoremap        d "_d
xnoremap        xx dd

" Explorer configuration
nnoremap 	<Leader>fo :CocCommand explorer<Enter>

" ctrlp sets
let             g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


" =-=-=-=-=-=-=-=-=-=-=-=-=-=
"
" Autocomplete settings
"
" =-=-=-=-=-=-=-=-=-=-=-=-=-=
 
" Personal sets
let             g:coc_global_extensions = [
                    \ 'coc-snippets',
                    \ 'coc-tsserver',
                    \ 'coc-phpls',
                    \ 'coc-json',
                    \ 'coc-pairs',
                    \ 'coc-eslint',
                    \ 'coc-prettier'
                    \ ]

inoremap        <silent><expr> <c-space> coc#refresh()
nnoremap 	<leader>ecsf :CocCommand snippets.editSnippets<cr>

" Default CocNVIM sets

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set             encoding=utf-8

" TextEdit might fail if hidden is not set.
set             hidden

" Some servers have issues with backup files, see #649.
set             nobackup
set             nowritebackup

" Give more space for displaying messages.
set             cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set             updatetime=300

" Don't pass messages to |ins-completion-menu|.
set             shortmess+=c

if has("patch-8.1.1564")
  set           signcolumn=number
else
  set           signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap        <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
inoremap        <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let           col = col('.') - 1
  return        !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap      <silent><expr> <c-space> coc#refresh()
else
  inoremap      <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap        <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap            <silent> [g <Plug>(coc-diagnostic-prev)
nmap            <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap            <silent> gd <Plug>(coc-definition)
nmap            <silent> gy <Plug>(coc-type-definition)
nmap            <silent> gi <Plug>(coc-implementation)
nmap            <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap        <silent> K :call <SID>show_documentation()<CR>

function!       s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute     'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call        CocActionAsync('doHover')
  else
    execute     '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd         CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap            <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap            <leader>f  <Plug>(coc-format-selected)
nmap            <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd       FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd       User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap            <leader>a  <Plug>(coc-codeaction-selected)
nmap            <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap            <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap            <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap            if <Plug>(coc-funcobj-i)
omap            if <Plug>(coc-funcobj-i)
xmap            af <Plug>(coc-funcobj-a)
omap            af <Plug>(coc-funcobj-a)
xmap            ic <Plug>(coc-classobj-i)
omap            ic <Plug>(coc-classobj-i)
xmap            ac <Plug>(coc-classobj-a)
omap            ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap      <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap      <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap      <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap      <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap      <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap      <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap            <silent> <C-s> <Plug>(coc-range-select)
xmap            <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command!        -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command!        -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command!        -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set             statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap        <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap        <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap        <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap        <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap        <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap        <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap        <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap        <silent><nowait> <space>p  :<C-u>CocListResume<CR>
