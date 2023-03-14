return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Gwrite",
    },
  },
  {
    "rbong/vim-flog",
    dependencies = { "tpope/vim-fugitive" },
    keys = {
      { "<leader>gx", ":vertical :Flogsplit -all -date=short<CR>", { desc = "Show git log tree" } },
    },
  },
}
