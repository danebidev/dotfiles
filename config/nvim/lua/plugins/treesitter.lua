local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
	-- Parsers {{{
	ensure_installeid = {
		"lua",
		"vimdoc",
		"query",
	},
	auto_install = false,
	-- }}}
	-- Highlight {{{
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	-- }}}
	-- Indent {{{
	indent = {
		enable = true,
	},
	-- }}}
	-- Incremental selection {{{
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = "<C-s>",
			node_decremental = "<M-space>",
		},
	},
	-- }}}
	-- Text Objects {{{
	textobjects = {
		-- Move {{{
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["gj"] = "@function.outer",
				["]]"] = "@class.outer",
				["]b"] = "@block.outer",
				["]a"] = "@parameter.inner",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["gJ"] = "@function.outer",
				["]["] = "@class.outer",
				["]B"] = "@block.outer",
				["]A"] = "@parameter.inner",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["gk"] = "@function.outer",
				["[["] = "@class.outer",
				["[b"] = "@block.outer",
				["[a"] = "@parameter.inner",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["gK"] = "@function.outer",
				["[]"] = "@class.outer",
				["[B"] = "@block.outer",
				["[A"] = "@parameter.inner",
			},
		},
		-- }}}
		-- Select {{{
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["a/"] = "@comment.outer",
				["i/"] = "@comment.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
			},
		},
		-- }}}
		-- Extra settings {{{
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
		autopairs = { enable = true },
		autotag = { enable = true },
		-- }}}
	},
	-- }}}
})
