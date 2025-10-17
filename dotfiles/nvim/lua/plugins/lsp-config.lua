return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})

      -- Goto Declaration (not just definition)
      vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {})

      -- Signature Help (shows function parameter hints)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {})

      -- Type Definition (e.g., jump to the class/struct definition)
      vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {})

      -- List Workspace Symbols (all classes/functions in project)
      vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, {})

      -- Show Diagnostics in a floating window
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})

      -- Go to Previous Diagnostic
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})

      -- Go to Next Diagnostic
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})

      -- Show All Diagnostics (like `:Diagnostics`)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {})

      -- Restart the LSP
      vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", {})

      -- Add/Remove workspace folder
      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, {})
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, {})

      -- List workspace folders
      vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, {})
    end,
  },
}
