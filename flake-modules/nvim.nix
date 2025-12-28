{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # We use 'with pkgs;' to make the list cleaner
    extraPackages = with pkgs; [
      tree-sitter
      gcc
      # Recommended: Telescope usually needs these to function fully
      ripgrep 
      fd
    ];

    extraLuaConfig = ''
      -- Bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      require("lazy").setup({
        spec = {
          { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
          { "neovim/nvim-lspconfig" },
          { "nvim-lualine/lualine.nvim" },
          { "nvim-tree/nvim-tree.lua" },
          { "hrsh7th/nvim-cmp" },
          { "hrsh7th/cmp-nvim-lsp" },
          { "hrsh7th/cmp-buffer" },
          { "hrsh7th/cmp-path" },
          { "L3MON4D3/LuaSnip" },
          { "saadparwaiz1/cmp_luasnip" },
          { "tpope/vim-fugitive" },
          { "lewis6991/gitsigns.nvim" },
          { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } },
        },
        defaults = { lazy = true },
      })

      vim.o.number = true
      vim.o.relativenumber = true
      vim.o.tabstop = 2
      vim.o.shiftwidth = 2
      vim.o.expandtab = true
      vim.o.smartindent = true
      vim.o.wrap = false
      vim.o.termguicolors = true

      require("lualine").setup({
        options = { theme = "gruvbox", section_separators = "", component_separators = "" }
      })

      require("nvim-tree").setup({
        sort_by = "name",
        view = { width = 30 },
        renderer = { group_empty = true },
      })

      require("gitsigns").setup()
    '';
  };
}
