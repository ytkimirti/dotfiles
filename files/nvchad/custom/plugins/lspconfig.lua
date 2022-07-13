local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   local servers = { "html", "cssls", "bashls", "emmet_ls", "clangd", "pyright" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
         root_dir = vim.loop.cwd,
      }
   end

   -- C# config
   local pid = vim.fn.getpid()
   local omnisharp_bin = "/Library/Frameworks/Mono.framework/Versions/Current/Commands/mono"

   lspconfig.omnisharp.setup{
      use_mono = true,
       cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) }
   }

   -- temporarily disable tsserver suggestions
   require("lspconfig").tsserver.setup {
      init_options = {
         preferences = {
            disableSuggestions = true,
         },
      },

      on_attach = function(client, bufnr)
         client.resolved_capabilities.document_formatting = false
         vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
      end,
   }
end

return M
