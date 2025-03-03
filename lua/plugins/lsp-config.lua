return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = "Mason",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					height = 0.8,
				}
			})
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pylsp" },
				automatic_installation = true,
			})
		end
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			-- Configuration commune pour tous les serveurs
			local default_config = {
				capabilities = capabilities,
				flags = {
					debounce_text_changes = 150,
				},
				on_attach = function(client, bufnr)
					-- Désactiver le formatage intégré si vous utilisez null-ls
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false

					-- Configuration des keymaps
					local opts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
				end,
			}

			-- Configuration spécifique pour lua_ls
			lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", default_config, {
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' }
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			}))

			-- Configuration pour pylsp
			lspconfig.pylsp.setup(vim.tbl_deep_extend("force", default_config, {
				settings = {
					pylsp = {
						plugins = {
							pycodestyle = {
								ignore = {'W391'},
								maxLineLength = 100
							},
						},
					},
				},
			}))

			-- Configuration des diagnostics
			vim.diagnostic.config({
				virtual_text = false,
				severity_sort = true,
				float = {
					border = 'rounded',
					source = 'always',
					header = '',
					prefix = '',
				},
			})
		end
	}
}
