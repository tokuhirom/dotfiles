-- install vim-plug by following command.
-- curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

-- :PlugInstall to install plugins.



require('opts')
require('keys')
require('vimplug')

----- plugins ---

-- buffer tabs
require('plugins/bufferline')

require('plugins/ctrlp')
require('plugins/nvim-tree')
require('plugins/lualine')
--  require('plugins/cmp')

vim.cmd('colorscheme tokyonight')

