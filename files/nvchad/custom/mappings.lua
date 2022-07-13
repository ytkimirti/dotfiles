local M = {}

-- NOTE: THE NAMES DOESN'T MATTER AT ALLL

M.disabled = {
   n = {
      ["<leader>pt"] = "",
   }
}

M.kitty = {
   n = {
      ["<C-h>"] = {"<cmd> KittyNavigateLeft <CR>", "left"},
      ["<C-j>"] = {"<cmd> KittyNavigateDown <CR>", "down"},
      ["<C-k>"] = {"<cmd> KittyNavigateUp <CR>", "up"},
      ["<C-l>"] = {"<cmd> KittyNavigateRight <CR>", "right"},
   }
}

M.yanking = {
   n = {
      [",p"] = {'"0p'},
      [",P"] = {'"0P'},

      ["<leader>p"] = {'"*p', "Paste to front from clipboard"},
      ["<leader>P"] = {'"*P', "Paste to back from clipboard"},

      ["y"] = {'"*y'},
      ["Y"] = {'"*Y'},
   }
}

M.general = {
   n = {
      ["<leader>sc"] = {"<cmd> source ~/.config/nvim/init.lua <CR>", "勒  Source config"},
      ["<C-/>"] = {
         function()
            require("Comment.api").toggle_current_linewise()
         end,

         "蘒  toggle comment",
      },
   },

   v = {
      ["<C-/>"] = {
         "<ESC><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>",
         "蘒  toggle comment",
      },
   },
}

M.truzen = {
   n = {
      ["<leader>ta"] = { "<cmd> TZAtaraxis <CR>", "   truzen ataraxis" },
      ["<leader>tm"] = { "<cmd> TZMinimalist <CR>", "   truzen minimal" },
      ["<leader>tf"] = { "<cmd> TZFocus <CR>", "   truzen focus" },
   },
}

M.treesitter = {
   n = {
      ["<leader>cu"] = { "<cmd> TSCaptureUnderCursor <CR>", "  find media" },
   },
}

M.shade = {
   n = {
      ["<leader>s"] = {
         function()
            require("shade").toggle()
         end,

         "   toggle shade.nvim",
      },
   },
}

return M
