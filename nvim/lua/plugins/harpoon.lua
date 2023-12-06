return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>hm",
      function()
        require("harpoon.mark").toggle_file(nil)
      end,
      desc = "Harpoon mark file",
    },
    {
      "<leader>hh",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon toggle quick menu",
    },
    {
      "<leader>hk",
      function()
        require("harpoon.ui").nav_next()
      end,
      desc = "Harpoon next",
    },
    {
      "<leader>hj",
      function()
        require("harpoon.ui").nav_prev()
      end,
      desc = "Harpoon previous",
    },
  },
}
