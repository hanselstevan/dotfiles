"Idk
syntax on
set rnu
set background=dark
let NERDTreeShowHidden=1
set wildmode=longest,list,full

"Plugins
call plug#begin()
Plug 'junegunn/limelight.vim'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'chrisbra/Colorizer'
call plug#end()

"Colorscheme
set termguicolors
set background=dark
colorscheme gruvbox
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
autocmd vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
let g:limelight_conceal_guifg = '#999999'

"Keymap
nmap fr :source %<cr>
nmap fc :ColorToggle<cr>
nmap f\ :Limelight!!<cr>
nmap fe :NERDTreeToggle<cr>
nmap fn :tabnew<cr>
nmap fl :tabnext<cr>
nmap fh :tabprev<cr>
nmap qq :q<cr>
