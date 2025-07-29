-- lua/plugins/lspconfig.lua
-- Plugin configuration for Neovim LSP (Pyright only)
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- 1. Make sure the servers are installed via Mason.
      require("mason").setup({ PATH = "prepend" })

      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = { "pyright" },
        automatic_enable = false, -- we'll configure manually to avoid duplicates
      })

      local lspconfig = require("lspconfig")
      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, bufopts)

        -- Automatically start semantic tokens if the server supports it
        if client.server_capabilities.semanticTokensProvider then
          vim.lsp.semantic_tokens.start(bufnr, client.id)
        end
      end

      -- Configure capabilities for LSP, including semantic tokens (Neovim ≥0.9)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- All servers will use UTF-8 byte offsets to avoid Neovim’s
      -- position-encoding mismatch warning when multiple clients attach.
      capabilities.offsetEncoding = { "utf-8" }
      -- Configure semantic token capabilities for Neovim ≥0.9
      capabilities.textDocument.semanticTokens = {
        dynamicRegistration = false,
        requests = {
          full = true,
          range = true,
        },
        tokenTypes = vim.tbl_keys(vim.lsp.protocol.SemanticTokenTypes or {}),
        tokenModifiers = vim.tbl_keys(vim.lsp.protocol.SemanticTokenModifiers or {}),
        formats = { "relative" },
        overlappingTokenSupport = true,
        multilineTokenSupport = true,
      }

      -- 2. Configure servers manually (mason-lspconfig v2 removed
      --    setup_handlers).  This guarantees exactly one instance of
      --    each client and keeps full control over individual settings.

      local servers = {
        -- Pyright with type-checking enabled (no Ruff for linting)
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
              },
            },
          },
        },

        -- Ruff disabled - too opinionated for this setup
        -- ruff = {},
      }

      for name, opts in pairs(servers) do
        opts.on_attach = on_attach
        opts.capabilities = capabilities
        lspconfig[name].setup(opts)
      end

      -- No manual semantic-token highlight linking – we now rely on
      -- the colourscheme (e.g. Catppuccin) to provide proper styles.
    end,
  },
}
