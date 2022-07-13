local M = {}

--[[
# Notes
`lua/core/default_config.lua` has the structure


--]]

M.ui = {
   theme = 'gruvchad',
   hl_add = require "custom.highlights",
}

M.plugins = {
   -- Override init settings for stuff like
   -- nvim-tree or treesitter
   override = require("custom.override"),

   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig"
      }
   },

   -- My plugins
   user = require("custom.plugins")
}

M.mappings = require("custom.mappings")


return M

-- local override = require "custom.override"


-- M.plugins = {
--
--    options = {
--       lspconfig = {
--          setup_lspconf = "custom.plugins.lspconfig",
--       },
--    },
--
--    override = {
--       ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
--       ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
--       ["lukas-reineke/indent-blankline.nvim"] = override.blankline,
--    },
--
--    user = require "custom.plugins",
-- }
--
-- M.ui = {
--    theme = "gruvchad",
--    hl_add = require "custom.highlights",
--    theme_toggle = { "gruvchad", "gruvbox_light" },
-- }
--
-- M.mappings = require "custom.mappings"
--
-- return M
