
local M = {}

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ===============================
-- Helix-like keybindings for NvChad
-- ===============================

-- Go to end of line (gl)
map("n", "gl", "$", opts)
map("v", "gl", "$", opts)

-- Go to end of file (ge)
map("n", "ge", "G", opts)
map("v", "ge", "G", opts)

-- Select current line (x)
-- In normal mode, start visual line mode on the current line
map("n", "x", "V", opts)

-- Symbol picker (Space + s)
-- Uses Telescope's LSP document symbols if available
map("n", "<leader>s", "<cmd>Telescope lsp_document_symbols<CR>", opts)

-- File picker (Space + f)
map("n", "<leader>f", "<cmd>Telescope find_files<CR>", opts)

-- Optional: Buffer picker (Space + b)
map("n", "<leader>b", "<cmd>Telescope buffers<CR>", opts)

-- Optional: Line search (Space + /)
map("n", "<leader>/", "<cmd>Telescope live_grep<CR>", opts)

-- Optional: Toggle file tree (Space + e)
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)

map("n", "gs", "^", opts)  -- go to start of line
map("n", "gg", "gg", opts)  -- go to start of file (default)

-- Integrated terminal (Space + I)
map("n", "<leader>i", function() require("nvchad.term").toggle() end, opts)

-- Cycle through buffers
map("n", "<Tab>", "<cmd>bnext<CR>", opts)
map("n", "<S-Tab>", "<cmd>bprevious<CR>", opts)

-- Symbol definition (Space + K)
map("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

-- Theme picker (Space + T)
map("n", "<leader>t", "<cmd>Telescope themes<CR>", opts)

-- Symbol Rename (Space + R)
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

-- Close buffer (Space + x)
map("n", "<leader>x", "<cmd>bd<CR>", opts)


-- Integrated terminal (Space + I)
map("n", "<leader>i", function() require("nvchad.term").toggle({ pos = "float", id = "floatTerm" }) end, opts)


-- Toggle terminal even from terminal mode (add this to your mappings)
-- map("t", "<leader>i", function() require("nvchad.term").toggle { pos = "float", id = "floatTerm" } end, { desc = "Toggle floating terminal" })
return M
