syntax on
:set nu
autocmd vimenter * ++nested colorscheme gruvbox
set background=dark
execute pathogen#infect()
filetype plugin indent on
let g:airline_powerline_fonts = 1
