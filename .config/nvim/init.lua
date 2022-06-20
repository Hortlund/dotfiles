vim.o.syntax = "on"
vim.o.nu = true 
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.autoread = true
vim.o.ma = true
vim.o.cursorline = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 2
vim.o.confirm = true
vim.o.autoindent = true 
vim.o.textwidth = 100
vim.o.linebreak = true
vim.o.wrap = true
--vim.o.expandtab = true

vim.cmd('filetype plugin on')

vim.cmd('set tags=./tags,tags,~/Documents/git/tags')

vim.opt.list = true
vim.opt.listchars = { tab = '>~', trail = '~', extends = '>', precedes = '<', nbsp = '%', space = '·' }

vim.api.nvim_command('autocmd BufRead,BufNewFile /Users/andreas.hortlund/Documents/git/air8/* setlocal fileencodings=iso-8859-1')
vim.api.nvim_command('au BufNewFile,BufRead *.tt set filetype=tt2html')

require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'folke/tokyonight.nvim'
	use {
  		'nvim-telescope/telescope.nvim',
  		requires = { {'nvim-lua/plenary.nvim'}, {'nvim-treesitter/nvim-treesitter'} }
	}
	use {
  		'nvim-lualine/lualine.nvim',
  		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use {
  		'pwntester/octo.nvim',
  		requires = {
    			'nvim-lua/plenary.nvim',
    			'nvim-telescope/telescope.nvim',
    			'kyazdani42/nvim-web-devicons',
  		},
  		config = function ()
    			require"octo".setup()
  		end
	}
	use {
		'zivyangll/git-blame.vim'
	}
end)

-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--Get store
store = os.getenv("ASKAS_BUTIK")

-- lualine
require('lualine').setup{
  sections = {
    lualine_c = {{'filename', file_status = true, path = 2}},
	lualine_x = {"store",'encoding', 'fileformat', 'filetype'}
  }
}
vim.cmd[[let g:tokyonight_style = "night"]]
vim.cmd[[let g:tokyonight_italic_functions = 1]]

vim.cmd[[colorscheme tokyonight]]

--nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
--nnoremap <backspace> <C-]>
--nnoremap <tab>       <C-T>
map("n", "<backspace>", "<C-]>")
map("n", "<tab>", "<C-T>")
map("n", "<C-p>", "<cmd>Telescope find_files<CR>")
map("n", "<C-f>", "<cmd>Telescope live_grep<CR>")
map("n", "<Leader>f", "<cmd>Telescope grep_string<CR>")
map("n", "<Leader>s", ":<C-u>call gitblame#echo()<CR>")
map("n", "<Leader>b", ":! perl /Users/andreas.hortlund/Documents/git/air8/_VERKTYG/publish.pm %:p 1<CR>")
