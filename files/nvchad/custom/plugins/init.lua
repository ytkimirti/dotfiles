return {
   ['tpope/vim-surround'] = {},
   ['knubie/vim-kitty-navigator'] = {
      cmd = {
         "KittyNavigateLeft",
         "KittyNavigateRight",
         "KittyNavigateUp",
         "KittyNavigateDown",
      }
   },

   ['bfredl/nvim-luadev'] = {
      cmd = "Luadev"
   },

   -- format & linting
   ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.null-ls"
      end,
   },

   -- minimal modes
   -- ["Pocco81/TrueZen.nvim"] = {
   --    cmd = {
   --       "TZAtaraxis",
   --       "TZMinimalist",
   --       "TZFocus",
   --    },
   --    config = function()
   --       require "custom.plugins.truezen"
   --    end,
   -- },

   -- notes stuff
   -- ["nvim-neorg/neorg"] = {
   --    ft = "norg",
   --    after = "nvim-treesitter",
   --    config = function()
   --       require "custom.plugins.neorg"
   --    end,
   -- },

   -- get highlight group under cursor
   -- ["nvim-treesitter/playground"] = {
   --    cmd = "TSCaptureUnderCursor",
   --    config = function()
   --       require("nvim-treesitter.configs").setup()
   --    end,
   -- },

   -- dim inactive windows
   -- ["andreadev-it/shade.nvim"] = {
   --    module = "shade",
   --    config = function()
   --       require("custom.plugins.smolconfigs").shade()
   --    end,
   -- },

   -- ["Pocco81/AutoSave.nvim"] = {
   --    module = "autosave",
   --    config = function()
   --       require("custom.plugins.smolconfigs").autosave()
   --    end,
   -- },
}
