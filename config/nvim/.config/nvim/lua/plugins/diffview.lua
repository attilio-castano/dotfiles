return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "File history (all)" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
    },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        use_icons = true,
        signs = {
          fold_closed = "",
          fold_open = "",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = true,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = false,
            folder_statuses = "only_folded"
          },
          win_config = {
            position = "left",
            width = 35,
          },
        },
        keymaps = {
          view = {
            ["q"] = "<cmd>DiffviewClose<cr>",
          },
          file_panel = {
            ["s"] = require("diffview.actions").stage_all,
            ["u"] = require("diffview.actions").unstage_all,
            ["q"] = "<cmd>DiffviewClose<cr>",
          },
        },
      })
    end,
  },
}