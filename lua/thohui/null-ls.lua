local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local hover = null_ls.builtins.hover

local augroup = vim.api.nvim_create_augroup("Format", { clear = true })

null_ls.setup({
	debug = true,
	sources = {
		formatting.prettierd.with({ extra_filetypes = { "astro" } }),
		formatting.black,
		formatting.isort,
		diagnostics.eslint_d,
		code_actions.eslint_d,
	},
	on_attach = function(client, bufnr)
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
