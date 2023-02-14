-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
      -- Packer can manage itself
      use("wbthomason/packer.nvim")

      use({
          "nvim-telescope/telescope.nvim",
          tag = "0.1.0",
          -- or                            , branch = '0.1.x',
          requires = { { "nvim-lua/plenary.nvim" } },
      })
      use({
          "rose-pine/neovim",
          as = "rose-pine",
          config = function()
            require("rose-pine").setup({
                --- @usage 'main' | 'moon'
                dark_variant = "moon",
            })
            vim.cmd("colorscheme rose-pine")
          end,
      })

      use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
      use("ThePrimeagen/harpoon")
      use("mbbill/undotree")
      use("tpope/vim-fugitive")
      use({
          "numToStr/Comment.nvim",
          config = function()
            require("Comment").setup()
          end,
      })

      use({
          "VonHeikemen/lsp-zero.nvim",
          requires = {
              -- LSP Support
              { "neovim/nvim-lspconfig" }, -- Required
              { "williamboman/mason.nvim" }, -- Optional
              { "williamboman/mason-lspconfig.nvim" }, -- Optional

              -- Autocompletion
              { "hrsh7th/nvim-cmp" }, -- Required
              { "hrsh7th/cmp-nvim-lsp" }, -- Required
              { "hrsh7th/cmp-buffer" }, -- Optional
              { "hrsh7th/cmp-path" }, -- Optional
              { "saadparwaiz1/cmp_luasnip" }, -- Optional
              { "hrsh7th/cmp-nvim-lua" }, -- Optional

              -- Snippets
              { "L3MON4D3/LuaSnip" }, -- Required
              { "rafamadriz/friendly-snippets" }, -- Optional
          },
      })

      use("jose-elias-alvarez/null-ls.nvim")
      use("jayp0521/mason-null-ls.nvim")

      use({
          "L3MON4D3/LuaSnip",
          -- follow latest release.
          tag = "v<CurrentMajor>.*",
          -- install jsregexp (optional!:).
          run = "make install_jsregexp",
      })

      use({
          "folke/zen-mode.nvim",
          config = function()
            require("zen-mode").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                plugins = {
                    -- disable some global vim options (vim.o...)
                    -- comment the lines to not apply the options
                    options = {
                        enabled = true,
                        ruler = false, -- disables the ruler text in the cmd line area
                        showcmd = false, -- disables the command in the last line of the screen
                    },
                },
            })
          end,
      })

      use({
          "nvim-lualine/lualine.nvim",
          requires = { "kyazdani42/nvim-web-devicons", opt = true },
      })
    end)
