-- Plugins >>>
--if (empty(glob('~/.config/nvim/site/pack/paqs/opt/paq-nvim'))) then
--  os.execute("curl -fLo ~/.config/nvim/site/pack/paqs/opt/paq-nvim --create-dirs https://raw.githubusercontent.com/savq/paq-nvim/master/plugin/paq-nvim.vim")
--  api.nvim_command('autocmd VimEnter * PaqInstall')
--  api.nvim_command('autocmd VimEnter * source ~/.config/nvim.lua')
--end
vim.cmd([[packadd paq-nvim]])
local paq = require('paq-nvim').paq
paq{'savq/paq-nvim', opt = true}
-- Undo graphical tree
paq 'simnalamburt/vim-mundo'
-- LSP
paq 'neovim/nvim-lspconfig'
paq 'nvim-lua/completion-nvim'
paq 'ojroques/nvim-lspfuzzy'
-- Code formatting (until LSP formatting takes custom mode)
paq 'rhysd/vim-clang-format'
-- Fuzzy finding of files/buffers etc
paq 'junegunn/fzf' --, { 'dir': '~/.fzf', 'do': './install --all' }
paq 'junegunn/fzf.vim'
-- Syntax highlighters
--Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
paq 'iramaKamari/vimcolors'
paq 'bfrg/vim-cpp-modern'
paq 'vim-python/python-syntax'
--paq 'rktjmp/lush.nvim' colortheme creator
-- <<<

-- Editor mappings and settings
-- Remap leader to space >>>
vim.api.nvim_set_keymap('', '<space>', '<nop>', { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- <<<
-- Syntax, color and highlight >>>
vim.api.nvim_command([[syntax enable]])
vim.api.nvim_set_var('gruvbox_termcolors', 256)
vim.api.nvim_set_var('rbpt_colorpairs', 1)
vim.api.nvim_set_var('rainbow_conf', 1)
vim.api.nvim_command([[silent! colorscheme gruvbox]])
-- Highlight leading whitespace
vim.api.nvim_set_keymap('n', '<leader>i', '/^\\s\\+/<CR>', { noremap = true, silent = true })
-- Highlight trailing whitespace
vim.api.nvim_command('hi ExtraWhitespace ctermbg=124 guibg=#cc241d')
vim.api.nvim_exec([[
match ExtraWhitespace /\s\+$/
autocmd BufEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufLeave * call clearmatches()
]], false)
-- Trim trailing whitespace
vim.api.nvim_set_keymap('n', '<leader>T', ':call TrimWhitespace()<CR>', { noremap = true, silent = false })
vim.api.nvim_exec([[
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
]], false)
-- <<<
-- Global
vim.api.nvim_command([[set noswapfile nobackup noshowmode]])
vim.api.nvim_set_option('termguicolors', true)
vim.api.nvim_set_option('autoread', true)
vim.api.nvim_set_option('guicursor', "")
vim.api.nvim_set_option('lazyredraw', true)
vim.api.nvim_set_option('showmatch', true)
vim.api.nvim_set_option('complete', '.,w,b,u,t')
vim.api.nvim_set_option('completeopt', 'menu,noinsert,noselect')
vim.api.nvim_set_option('wildmode', 'longest:full,full')
-- Omnicomple in insert mode
vim.api.nvim_exec([[
autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
]], false)
vim.api.nvim_command([[set path+=**]])

-- Window >>>
-- Split
vim.api.nvim_command([[set splitbelow splitright]])
vim.api.nvim_exec([[autocmd VimResized * wincmd =]], false)
vim.api.nvim_set_keymap('n', '<leader>w', ':split<CR>', { noremap = true, silent = true })
-- Vertical split
vim.api.nvim_set_keymap('n', '<leader>v', ':vs<CR>', { noremap = true, silent = true })
-- Change split layout
vim.api.nvim_set_keymap('n', '<A-j>', '<C-w>J', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-k>', '<C-w>K', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-l>', '<C-w>L', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-h>', '<C-w>H', { noremap = true, silent = true })
-- Change split dimensions
vim.api.nvim_set_keymap('n', '<A-Up>', '<C-w><C-+>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-Down>', '<C-w><C-->', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-Left>', '<C-w><C->>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-Right>', '<C-w><C-<>', { noremap = true, silent = true })
-- <<<

-- Navigation >>>
vim.api.nvim_command([[set number relativenumber]])
vim.api.nvim_exec([[
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
]], false)
-- Go to last used buffer
vim.api.nvim_set_keymap('n', '<leader>b', '<C-^>', { noremap = true, silent = true })
-- Display active buffers and prep for :buffer<COMMAND>
vim.api.nvim_set_keymap('n', '§', ':ls<CR>:b<space>', { noremap = true, silent = true })
-- Between splits
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', { noremap = true, silent = true })
-- Don't skip wrapped lines
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
-- Zoom / Restore window.
vim.api.nvim_exec([[
function! ZoomToggle()
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
]], false)
vim.api.nvim_set_keymap('n', '<leader>z', ':call ZoomToggle()<CR>', { noremap = true, silent = true })
-- <<<

-- Editing >>>
-- Buffer settings
vim.api.nvim_buf_set_option(0, 'textwidth', 0)
vim.api.nvim_buf_set_option(0, 'tabstop', 2)
vim.api.nvim_buf_set_option(0, 'softtabstop', 2)
vim.cmd([[set shiftwidth=2]])
vim.api.nvim_buf_set_option(0, 'expandtab', true)
vim.api.nvim_set_option('hidden', true)
--vim.api.nvim_buf_set_option(0, 'formatoptions', 'crqn1j')

-- Move lines up and down in normal/insert/visual mode
vim.api.nvim_set_keymap('n', '<S-Down>', ':m +1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Up>', ':m -2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Down>', '<Esc>:m +1<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Up>', '<Esc>:m -2<CR>==gi', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Down>', '<Esc>:m +1<CR>gv=gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Up>', '<Esc>:m -2<CR>gv=gv', { noremap = true, silent = true })

-- Quicksave current buffer
vim.api.nvim_set_keymap('n', '<leader>s', ':w<CR>', { noremap = true, silent = true })
-- Escape as kk
vim.api.nvim_set_keymap('i', 'kk', '<esc>', { noremap = true, silent = true })
-- To open new file
vim.api.nvim_set_keymap('n', '<leader>e', ':e ', { noremap = true, silent = false })
-- Replace local/global
vim.api.nvim_set_keymap('n', '<leader>r', ':s/<C-r><C-w>//g<Left><Left>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', '<leader>R', ':%s/<C-r><C-w>//gc<Left><Left><Left>', { noremap = true, silent = false })
-- Searching
vim.api.nvim_set_keymap('n', '<leader><space>', ':nohlsearch<CR>', { noremap = true, silent = true })
-- Range commands for incsearch
vim.api.nvim_set_keymap('c', '$t', '<CR>:t\'\'<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '$m', '<CR>:m\'\'<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '$d', '<CR>:d<CR>``', { noremap = true, silent = true })

-- Python
vim.api.nvim_set_var('python2_host_prog', "/usr/bin/python")
vim.api.nvim_set_var('python3_host_prog', "/usr/bin/python3")
vim.api.nvim_set_var('python_recommended_style', 1)
vim.api.nvim_set_var('python_highlight_all', 1)

-- Code formatting
vim.api.nvim_set_var('clang_format#code_style', "chromium")

-- <<<

-- GIT
vim.api.nvim_set_keymap('', '<leader>l', ':te tig %<Return>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<leader>B', ':te tig blame +<C-r>=line(\'.\')<Return> %<Return>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<leader>D', ':te git diff %<Return>i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<leader>V', ':te git checkout -p %<Return>i', { noremap = true, silent = true })

-- Mundo settings
vim.api.nvim_set_var('mundo_preview_bottom', 1)
vim.api.nvim_set_var('mundo_preview_height', 50)
vim.api.nvim_set_var('mundo_close_on_revert', 1)
vim.api.nvim_set_keymap('n', '<leader>u', ':MundoToggle<CR>', { noremap = true, silent = true })

-- Terminal mode mappings<C-\><C-n>:file<space>
vim.api.nvim_set_keymap('n', '<leader>t', ':terminal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>:b#<CR>', { noremap = true, silent = true })
vim.api.nvim_exec([[
autocmd BufEnter,WinEnter,TermOpen,FocusGained term://* startinsert
autocmd BufLeave term://* stopinsert
]], false)
-- Quit
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })

-- Load own plugins last, order matters
require('vimplugins.lspsettings')
require('vimplugins.statusline')
require('vimplugins.fzf')
