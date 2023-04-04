return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        on_attach = function(_, bufnr)
          vim.keymap.set(
            "n",
            "<leader>a",
            "<cmd>ClangdSwitchSourceHeader<cr>",
            { buffer = bufnr, desc = "LSP: Switch between C/C++ header/source files" }
          )
        end,
      },
      bashls = {},
      pyright = {},
      astro = {},
      svelte = {},
      eslint = {},
      tsserver = {
        root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
        single_file_support = false,
      },
      denols = {
        root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
      },
      gopls = {},
      jdtls = {
        root_dir = require("lspconfig").util.root_pattern(".project"),
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-1.8",
                  path = "/usr/java/jdk1.8.0_25",
                  default = true,
                },
              },
            },
          },
        },
      },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
