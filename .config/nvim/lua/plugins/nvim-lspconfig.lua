return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig" },
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-buffer" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "L3MON4D3/LuaSnip" },
	},
	init = function()
		-- エラーが出ている箇所の行の背景色を変える
		local colors = require("utils.colors")
		local palette = colors.palette

		vim.api.nvim_set_hl(0, "DiagnosticErrorLine", { bg = colors.opacity(palette.red, palette.base, 0.15) })
		vim.api.nvim_set_hl(0, "DiagnosticWarnLine", { bg = colors.opacity(palette.peach, palette.base, 0.15) })
		vim.api.nvim_set_hl(0, "DiagnosticHintLine", { bg = colors.opacity(palette.green, palette.base, 0.15) })
		vim.api.nvim_set_hl(0, "DiagnosticInfoLine", { bg = colors.opacity(palette.blue, palette.base, 0.15) })

		vim.diagnostic.config({
			signs = {
				text = {},
				linehl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
					[vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
					[vim.diagnostic.severity.HINT] = "DiagnosticHintLine",
					[vim.diagnostic.severity.INFO] = "DiagnosticInfoLine",
				},
			},
		})
	end,
	config = function()
		-- ref. https://github.com/neovim/nvim-lspconfig/wiki/Snippets

		local servers = {
			"bashls",
			"cssls",
			"docker_compose_language_service",
			"dockerls",
			"eslint",
			"graphql",
			"html",
			"jsonls",
			"lua_ls",
			"marksman",
			"rubocop",
			"ruby_lsp",
			"solargraph",
			"sqlls",
			"ts_ls",
			"volar",
			"yamlls",
		}

		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_installation = true,
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local lspconfig = require("lspconfig")
		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				capabilities = capabilities,
			})
		end

		local luasnip = require("luasnip")

		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-l>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
			}),
		})
	end,
}
