return { 
	"nvim-telescope/telescope.nvim",
	tag = '0.1.8',
	dependencies = { 
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
	},
	cmd = "Telescope",
	keys = {
		{ '<C-f>', function() require('telescope.builtin').find_files() end },
		{ '<leader>f', function() require('telescope.builtin').live_grep() end },
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				file_ignore_patterns = { ".git/", "node_modules/" },
				path_display = { "truncate" },
				set_env = { COLORTERM = "truecolor" },
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
				},
			},
			pickers = {
				find_files = { theme = "dropdown" },
				live_grep = { theme = "dropdown" },
			},
		})
		telescope.load_extension('fzf')
	end
}
