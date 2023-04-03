local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

local protocol = require("vim.lsp.protocol")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- TODO: use vim.keymap.set
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "ra", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<C-j>", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("i", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>fm", "<Cmd>lua vim.lsp.buf.format()<CR>", opts)
	buf_set_keymap("n", "<leader>f", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)

	local status_ok, illuminate = pcall(require, "illuminate")
	if not status_ok then
		return
	end
	illuminate.on_attach(client)
end

protocol.CompletionItemKind = {
	"", -- Text
	"", -- Method
	"", -- Function
	"", -- Constructor
	"", -- Field
	"", -- Variable
	"", -- Class
	"ﰮ", -- Interface
	"", -- Module
	"", -- Property
	"", -- Unit
	"", -- Value
	"", -- Enum
	"", -- Keyword
	"﬌", -- Snippet
	"", -- Color
	"", -- File
	"", -- Reference
	"", -- Folder
	"", -- EnumMember
	"", -- Constant
	"", -- Struct
	"", -- Event
	"ﬦ", -- Operator
	"", -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	-- filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
	cmd = { "typescript-language-server", "--stdio" },
	capabilities = capabilities,
	root_dir = nvim_lsp.util.root_pattern("package.json"),
})


--Golang
nvim_lsp.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}

nvim_lsp.golangci_lint_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
}

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})


-- nvim_lsp.rust_analyzer.setup{
--   settings = {
--     ['rust-analyzer'] = {
--       diagnostics = {
--         enable = true;
--       }
--     }
--   }
-- }
nvim_lsp.tailwindcss.setup({})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = { spacing = 4, prefix = "●" },
	severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- for type, icon in pairs(signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end
local function lsp_server_diagnostic(buffer, severity, info)
  -- Get the LSP client for the current buffer
  local client_id = vim.lsp.get_active_clients()[1].id
  local client_name = vim.lsp.get_client_by_id(client_id).name

  -- Create the virtual text with the server name and diagnostic message
  local message = string.format("[%s] %s", client_name, info.message)
  return {{message, "LspDiagnosticsVirtualText"}}
end

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		cb = lsp_server_diagnostic
	},
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
