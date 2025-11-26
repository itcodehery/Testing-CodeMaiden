-- ~/.config/nvim/lua/core/helix-keymaps.lua
-- Complete Helix-style keybindings for Neovim
-- Replace core/keymaps.lua with this file

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Helper function to create mappings with descriptions
local function nmap(lhs, rhs, desc)
  map("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

local function vmap(lhs, rhs, desc)
  map("v", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

local function imap(lhs, rhs, desc)
  map("i", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- NORMAL MODE - Movement
-- ============================================================================
nmap("h", "h", "Move left")
nmap("<Left>", "h", "Move left")
nmap("j", "gj", "Move down (visual line)")
nmap("<Down>", "gj", "Move down")
nmap("k", "gk", "Move up (visual line)")
nmap("<Up>", "gk", "Move up")
nmap("l", "l", "Move right")
nmap("<Right>", "l", "Move right")

-- Word movement
nmap("w", "w", "Move next word start")
nmap("b", "b", "Move previous word start")
nmap("e", "e", "Move next word end")
nmap("W", "W", "Move next WORD start")
nmap("B", "B", "Move previous WORD start")
nmap("E", "E", "Move next WORD end")

-- Find/till character
nmap("f", "f", "Find next char")
nmap("F", "F", "Find previous char")
nmap("t", "t", "Find till next char")
nmap("T", "T", "Find till previous char")
nmap("<A-.>", ";", "Repeat last motion")

-- Line movement
nmap("gh", "0", "Go to line start")
nmap("gl", "$", "Go to line end")
nmap("<Home>", "0", "Move to line start")
nmap("<End>", "$", "Move to line end")

-- Page movement
nmap("<C-b>", "<C-b>", "Page up")
nmap("<PageUp>", "<C-b>", "Page up")
nmap("<C-f>", "<C-f>", "Page down")
nmap("<PageDown>", "<C-f>", "Page down")
nmap("<C-u>", "<C-u>", "Half page up")
nmap("<C-d>", "<C-d>", "Half page down")

-- Jumplist
nmap("<C-i>", "<C-i>", "Jump forward")
nmap("<C-o>", "<C-o>", "Jump backward")
nmap("<C-s>", "m'", "Save position to jumplist")

-- ============================================================================
-- NORMAL MODE - Changes
-- ============================================================================
nmap("r", "r", "Replace char")
nmap("R", '"0p', "Replace with yanked")
nmap("~", "~", "Switch case")
nmap("`", "gu", "To lowercase")
nmap("<A-`>", "gU", "To uppercase")

-- Insert modes
nmap("i", "i", "Insert before")
nmap("a", "a", "Insert after")
nmap("I", "I", "Insert at line start")
nmap("A", "A", "Insert at line end")
nmap("o", "o", "Open line below")
nmap("O", "O", "Open line above")
nmap(".", ".", "Repeat last insert")

-- Undo/redo
nmap("u", "u", "Undo")
nmap("U", "<C-r>", "Redo")
nmap("<A-u>", "g-", "Earlier")
nmap("<A-U>", "g+", "Later")

-- Yank/paste
nmap("y", "y", "Yank")
vmap("y", "y", "Yank selection")
nmap("p", "p", "Paste after")
nmap("P", "P", "Paste before")
nmap('"', '"', "Select register")

-- Indent
nmap(">", ">>", "Indent")
nmap("<", "<<", "Unindent")
vmap(">", ">gv", "Indent")
vmap("<", "<gv", "Unindent")

-- Delete/change
nmap("d", "d", "Delete")
vmap("d", "d", "Delete selection")
nmap("<A-d>", '"_d', "Delete without yank")
vmap("<A-d>", '"_d', "Delete selection without yank")
nmap("c", "c", "Change")
vmap("c", "c", "Change selection")
nmap("<A-c>", '"_c', "Change without yank")
vmap("<A-c>", '"_c', "Change selection without yank")

-- Increment/decrement
nmap("<C-a>", "<C-a>", "Increment number")
nmap("<C-x>", "<C-x>", "Decrement number")

-- Macros
nmap("Q", "q", "Record macro")
nmap("q", "@", "Replay macro")

-- ============================================================================
-- NORMAL MODE - Selection manipulation
-- ============================================================================
nmap("x", "V", "Select line")
nmap("X", "V", "Extend to line bounds")
nmap("<A-x>", "^v$h", "Shrink to line bounds")
nmap("%", "ggVG", "Select all")

-- Multi-cursor simulation (add cursors)
nmap("C", "yypk", "Copy line down")
nmap("<A-C>", "yyPj", "Copy line up")

-- Selection manipulation
nmap(";", "<Esc>", "Collapse selection")
nmap("<A-;>", "o", "Flip selection")
nmap(",", "<Esc>", "Keep primary selection")
nmap("<A-,>", "<Esc>", "Remove primary selection")

-- Join lines
nmap("J", "J", "Join lines")
nmap("<A-J>", "Jx", "Join lines with space")

-- Rotate selections (for multicursor - limited support)
nmap("(", "<Nop>", "Rotate selection backward")
nmap(")", "<Nop>", "Rotate selection forward")
nmap("<A-(>", "<Nop>", "Rotate contents backward")
nmap("<A-)>", "<Nop>", "Rotate contents forward")

-- ============================================================================
-- NORMAL MODE - Search
-- ============================================================================
nmap("/", "/", "Search")
nmap("?", "?", "Search backward")
nmap("n", "n", "Next search match")
nmap("N", "N", "Previous search match")
nmap("*", "*", "Search word under cursor")
nmap("<A-*>", '*', "Search selection")

-- ============================================================================
-- GOTO MODE (g prefix)
-- ============================================================================
nmap("gg", "gg", "Go to file start")
nmap("ge", "G", "Go to file end")
nmap("gh", "0", "Go to line start")
vmap("gh", "0", "Extend to line start")
nmap("gl", "$", "Go to line end")
vmap("gl", "$", "Extend to line end")
nmap("gs", "^", "Go to first non-whitespace")
vmap("gs", "^", "Extend to first non-whitespace")
nmap("gt", "H", "Go to top of screen")
nmap("gc", "M", "Go to middle of screen")
nmap("gb", "L", "Go to bottom of screen")
nmap("gd", vim.lsp.buf.definition, "Go to definition")
nmap("gy", vim.lsp.buf.type_definition, "Go to type definition")
nmap("gr", vim.lsp.buf.references, "Go to references")
nmap("gi", vim.lsp.buf.implementation, "Go to implementation")
nmap("ga", "<C-^>", "Go to alternate file")
nmap("gn", ":bnext<CR>", "Go to next buffer")
nmap("gp", ":bprevious<CR>", "Go to previous buffer")
nmap("g.", "`.", "Go to last modification")
nmap("gj", "j", "Move down textual line")
nmap("gk", "k", "Move up textual line")

-- ============================================================================
-- VIEW MODE (z prefix)
-- ============================================================================
nmap("zz", "zz", "Center view")
nmap("zc", "zz", "Center view")
nmap("zt", "zt", "Align top")
nmap("zb", "zb", "Align bottom")
nmap("zm", "zs", "Align middle (horizontal)")
nmap("zj", "<C-e>", "Scroll down")
nmap("zk", "<C-y>", "Scroll up")
nmap("<Down>", "<C-e>", "Scroll down")
nmap("<Up>", "<C-y>", "Scroll up")

-- Sticky view mode (Z) - same as z but persistent
nmap("Zz", "zz", "Center view")
nmap("Zc", "zz", "Center view")
nmap("Zt", "zt", "Align top")
nmap("Zb", "zb", "Align bottom")
nmap("Zm", "zs", "Align middle")
nmap("Zj", "<C-e>", "Scroll down")
nmap("Zk", "<C-y>", "Scroll up")

-- ============================================================================
-- MATCH MODE (m prefix)
-- ============================================================================
nmap("mm", "%", "Go to matching bracket")

-- Surround (requires nvim-surround plugin)
nmap("ms", "ys", "Surround add")
vmap("ms", "S<C-r>+", "Surround with system clipboard")
nmap("mr", "cs", "Surround replace")
nmap("md", "ds", "Surround delete")

-- Text objects
nmap("ma", "va", "Select around textobject")
nmap("mi", "vi", "Select inside textobject")

-- ============================================================================
-- WINDOW MODE (Ctrl-w prefix)
-- ============================================================================
nmap("<C-w>w", "<C-w>w", "Next window")
nmap("<C-w><C-w>", "<C-w>w", "Next window")
nmap("<C-w>v", ":vsplit<CR>", "Vertical split")
nmap("<C-w><C-v>", ":vsplit<CR>", "Vertical split")
nmap("<C-w>s", ":split<CR>", "Horizontal split")
nmap("<C-w><C-s>", ":split<CR>", "Horizontal split")
nmap("<C-w>h", "<C-w>h", "Move left")
nmap("<C-w><C-h>", "<C-w>h", "Move left")
nmap("<C-w><Left>", "<C-w>h", "Move left")
nmap("<C-w>j", "<C-w>j", "Move down")
nmap("<C-w><C-j>", "<C-w>j", "Move down")
nmap("<C-w><Down>", "<C-w>j", "Move down")
nmap("<C-w>k", "<C-w>k", "Move up")
nmap("<C-w><C-k>", "<C-w>k", "Move up")
nmap("<C-w><Up>", "<C-w>k", "Move up")
nmap("<C-w>l", "<C-w>l", "Move right")
nmap("<C-w><C-l>", "<C-w>l", "Move right")
nmap("<C-w><Right>", "<C-w>l", "Move right")
nmap("<C-w>q", ":q<CR>", "Close window")
nmap("<C-w><C-q>", ":q<CR>", "Close window")
nmap("<C-w>o", ":only<CR>", "Only this window")
nmap("<C-w><C-o>", ":only<CR>", "Only this window")
nmap("<C-w>H", "<C-w>H", "Move window left")
nmap("<C-w>J", "<C-w>J", "Move window down")
nmap("<C-w>K", "<C-w>K", "Move window up")
nmap("<C-w>L", "<C-w>L", "Move window right")

-- Pane/Window Navigation
nmap("<C-h>", "<C-w>h", "Move to left pane")
nmap("<C-j>", "<C-w>j", "Move to down pane")
nmap("<C-k>", "<C-w>k", "Move to up pane")
nmap("<C-l>", "<C-w>l", "Move to right pane")

-- ============================================================================
-- SPACE MODE (Space prefix) - Pickers and commands
-- ============================================================================
nmap("<leader>f", ":Telescope find_files<CR>", "File picker")
nmap("<leader>F", ":Telescope find_files cwd=%:p:h<CR>", "File picker (cwd)")
nmap("<leader>b", ":Telescope buffers<CR>", "Buffer picker")
nmap("<leader>j", ":Telescope jumplist<CR>", "Jumplist picker")
nmap("<leader>s", ":Telescope lsp_document_symbols<CR>", "Symbol picker")
nmap("<leader>S", ":Telescope lsp_workspace_symbols<CR>", "Workspace symbols")
nmap("<leader>d", ":Telescope diagnostics bufnr=0<CR>", "Diagnostics")
nmap("<leader>D", ":Telescope diagnostics<CR>", "Workspace diagnostics")
nmap("<leader>g", ":Telescope git_status<CR>", "Changed files")
nmap("<leader>k", vim.lsp.buf.hover, "Hover documentation")
nmap("<leader>r", vim.lsp.buf.rename, "Rename symbol")
nmap("<leader>a", vim.lsp.buf.code_action, "Code action")
nmap("<leader>h", vim.lsp.buf.document_highlight, "Highlight references")
nmap("<leader>'", ":Telescope resume<CR>", "Resume last picker")
nmap("<leader>w", "<C-w>", "Window mode")
nmap("<leader>c", "gcc", "Toggle comment")
nmap("<leader>C", "gcb", "Toggle block comment")
nmap("<A-c>", "gcc", "Toggle line comment")
nmap("<leader>p", '"+p', "Paste from clipboard")
nmap("<leader>P", '"+P', "Paste before from clipboard")
nmap("<leader>y", '"+y', "Yank to clipboard")
vmap("<leader>y", '"+y', "Yank to clipboard")
nmap("<leader>Y", '"+yy', "Yank line to clipboard")
nmap("<leader>R", '"+p', "Replace with clipboard")
nmap("<leader>/", ":Telescope live_grep<CR>", "Global search")
nmap("<leader>?", ":Telescope commands<CR>", "Command palette")

-- ============================================================================
-- UNIMPAIRED ([ and ] prefix)
-- ============================================================================
nmap("]d", vim.diagnostic.goto_next, "Next diagnostic")
nmap("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
nmap("]D", function() vim.diagnostic.goto_next({ count = math.huge }) end, "Last diagnostic")
nmap("[D", function() vim.diagnostic.goto_prev({ count = math.huge }) end, "First diagnostic")

-- Treesitter navigation (requires nvim-treesitter-textobjects)
nmap("]f", function() require("nvim-treesitter.textobjects.move").goto_next_start("@function.outer") end, "Next function")
nmap("[f", function() require("nvim-treesitter.textobjects.move").goto_previous_start("@function.outer") end, "Previous function")
nmap("]t", function() require("nvim-treesitter.textobjects.move").goto_next_start("@class.outer") end, "Next type/class")
nmap("[t", function() require("nvim-treesitter.textobjects.move").goto_previous_start("@class.outer") end, "Previous type/class")
nmap("]a", function() require("nvim-treesitter.textobjects.move").goto_next_start("@parameter.inner") end, "Next parameter")
nmap("[a", function() require("nvim-treesitter.textobjects.move").goto_previous_start("@parameter.inner") end, "Previous parameter")
nmap("]c", function() require("nvim-treesitter.textobjects.move").goto_next_start("@comment.outer") end, "Next comment")
nmap("[c", function() require("nvim-treesitter.textobjects.move").goto_previous_start("@comment.outer") end, "Previous comment")

-- Paragraph navigation
nmap("]p", "}", "Next paragraph")
nmap("[p", "{", "Previous paragraph")

-- Git hunks (requires gitsigns)
nmap("]g", function() require("gitsigns").next_hunk() end, "Next change")
nmap("[g", function() require("gitsigns").prev_hunk() end, "Previous change")

-- Add newlines
nmap("]<Space>", "o<Esc>", "Add newline below")
nmap("[<Space>", "O<Esc>", "Add newline above")

-- ============================================================================
-- SHELL (pipe commands)
-- ============================================================================
nmap("|", ":!", "Shell pipe")
nmap("<A-|>", ":!", "Shell pipe (ignore output)")
nmap("!", ":read !", "Insert shell output")
nmap("<A-!>", ":read !", "Append shell output")

-- ============================================================================
-- SELECTION (s and S for regex)
-- ============================================================================
-- These require additional plugins for proper implementation
nmap("s", "/", "Select regex matches")
nmap("S", ":s/", "Split on regex")
nmap("<A-s>", "V", "Split on newlines")

-- ============================================================================
-- COMMENT TOGGLE (Ctrl-c)
-- ============================================================================
nmap("<C-c>", "gcc", "Toggle comment")
vmap("<C-c>", "gc", "Toggle comment")

-- ============================================================================
-- TREESITTER TEXT OBJECTS (Alt-o, Alt-i, etc.)
-- ============================================================================
nmap("<A-o>", function() require("nvim-treesitter.textobjects.select").select_textobject("@block.outer", "textobjects") end, "Expand selection")
nmap("<A-up>", function() require("nvim-treesitter.textobjects.select").select_textobject("@block.outer", "textobjects") end, "Expand selection")
nmap("<A-i>", "vi{", "Shrink selection")
nmap("<A-down>", "vi{", "Shrink selection")
nmap("<A-p>", "[[", "Previous sibling")
nmap("<A-left>", "[[", "Previous sibling")
nmap("<A-n>", "]]", "Next sibling")
nmap("<A-right>", "]]", "Next sibling")

-- ============================================================================
-- INSERT MODE
-- ============================================================================
imap("<Esc>", "<Esc>", "Normal mode")
imap("<C-s>", "<Esc>:w<CR>a", "Save (commit checkpoint)")
imap("<C-x>", "<C-x><C-o>", "Autocomplete")
imap("<C-r>", "<C-r>", "Insert register")
imap("<C-w>", "<C-w>", "Delete word backward")
imap("<A-BS>", "<C-w>", "Delete word backward")
imap("<A-d>", "<C-o>dw", "Delete word forward")
imap("<A-Del>", "<C-o>dw", "Delete word forward")
imap("<C-u>", "<C-u>", "Delete to line start")
imap("<C-k>", "<C-o>D", "Delete to line end")
imap("<C-h>", "<BS>", "Delete char backward")
imap("<BS>", "<BS>", "Delete char backward")
imap("<S-BS>", "<BS>", "Delete char backward")
imap("<C-d>", "<Del>", "Delete char forward")
imap("<Del>", "<Del>", "Delete char forward")
imap("<C-j>", "<CR>", "New line")
imap("<CR>", "<CR>", "New line")

-- Optional: Arrow keys in insert mode (Helix allows but discourages)
-- imap("<Up>", "<Up>", "Move up")
-- imap("<Down>", "<Down>", "Move down")
-- imap("<Left>", "<Left>", "Move left")
-- imap("<Right>", "<Right>", "Move right")
-- imap("<PageUp>", "<PageUp>", "Page up")
-- imap("<PageDown>", "<PageDown>", "Page down")
-- imap("<Home>", "<Home>", "Line start")
-- imap("<End>", "<End>", "Line end")

-- ============================================================================
-- VISUAL/SELECT MODE (v for select mode)
-- ============================================================================
nmap("v", "v", "Enter select mode")
vmap("v", "<Esc>", "Exit select mode")

-- In visual mode, movements extend selection (this is default behavior)
vmap("h", "h", "Extend left")
vmap("j", "j", "Extend down")
vmap("k", "k", "Extend up")
vmap("l", "l", "Extend right")
vmap("w", "w", "Extend word")
vmap("e", "e", "Extend word end")
vmap("b", "b", "Extend word back")

-- Search extends in visual mode
vmap("n", "n", "Extend to next match")
vmap("N", "N", "Extend to prev match")

-- ============================================================================
-- ADDITIONAL HELIX-LIKE FEATURES
-- ============================================================================

-- Format selection (uses LSP)
nmap("=", vim.lsp.buf.format, "Format selection")
vmap("=", vim.lsp.buf.format, "Format selection")

-- Keep/remove selections (regex) - requires additional setup
nmap("<A-K>", "/", "Remove selections")

-- Align selections
nmap("&", "=", "Align selections")

-- Trim whitespace
nmap("_", ":%s/\\s\\+$//e<CR>", "Trim whitespace")

-- Merge selections
nmap("<A-minus>", "J", "Merge selections")
nmap("<A-_>", "J", "Merge consecutive")

-- ============================================================================
-- COMMAND MODE (: prefix)
-- ============================================================================
nmap(":", ":", "Command mode")
vmap(":", ":", "Command mode")

-- ============================================================================
-- GOTO COLUMN (g| prefix)
-- ============================================================================
nmap("g|", "0", "Go to column (needs count)")

-- ============================================================================
-- EXPERIMENTAL FEATURES
-- ============================================================================
-- Debug mode (Space-G) - not implemented in base Neovim
nmap("<leader>G", "<Nop>", "Debug mode (not implemented)")

-- Last accessed file variant
nmap("gm", "<C-6>", "Last modified file")

-- Goto word (gw) - requires hop.nvim or similar
nmap("gw", ":HopWord<CR>", "Goto word (requires hop.nvim)")

-- ============================================================================
-- DISABLED/CONFLICTING DEFAULTS
-- ============================================================================
-- Disable some default vim bindings that conflict with Helix
nmap("s", "<Nop>", "") -- Helix uses for select
nmap("S", "<Nop>", "") -- Helix uses for split selection

-- ============================================================================
-- BUFFER NAVIGATION
-- ============================================================================
nmap("<Tab>", ":bnext<CR>", "Next buffer")
nmap("<S-Tab>", ":bprevious<CR>", "Previous buffer")

