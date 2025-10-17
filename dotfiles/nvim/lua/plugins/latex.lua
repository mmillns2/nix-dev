return {
  -- VimTeX: Main LaTeX plugin
  {
    "lervag/vimtex",
    lazy = false, -- Load immediately
    init = function()
      vim.g.vimtex_view_method = "zathura"        -- Use Zathura for PDF viewing
      vim.g.vimtex_compiler_method = "latexmk"    -- Use latexmk for compilation
      vim.g.vimtex_quickfix_mode = 0              -- Disable quickfix auto open
    end,
  },

  -- Autocompletion for LaTeX (vimtex, symbols, etc.)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "micangl/cmp-vimtex",             -- VimTeX completions
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "kdheepak/cmp-latex-symbols",     -- LaTeX math symbol completions (optional)
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}

      -- Insert sources with high priority
      table.insert(opts.sources, 1, { name = "vimtex", priority = 1000 })
      table.insert(opts.sources, { name = "latex_symbols" })
    end,
  },
}
