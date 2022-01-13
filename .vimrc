"Idk
syntax on
set rnu
set background=dark
autocmd VimEnter * Limelight
let NERDTreeShowHidden=1
set wildmode=longest,list,full

"Plugins
call plug#begin()
Plug 'junegunn/limelight.vim'
Plug 'preservim/nerdtree'
Plug 'sainnhe/everforest'
call plug#end()

"Colorscheme
if has('termguicolors')
set termguicolors
endif
set background=dark
let g:everforest_better_performance = 1
colorscheme everforest
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
let g:limelight_conceal_guifg = '#999999'

"Keymap
nmap de :NERDTreeToggle<cr>
nmap dn :tabnew<cr>
nmap dl :tabnext<cr>
nmap dh :tabprev<cr>
nmap qq :q<cr>
