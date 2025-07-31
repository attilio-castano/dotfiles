return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local neogit = require("neogit")
      
      neogit.setup({
        disable_hint = false,
        disable_context_highlighting = false,
        disable_signs = false,
        disable_commit_confirmation = false,
        disable_insert_on_commit = "auto",
        filewatcher = {
          interval = 1000,
          enabled = true,
        },
        graph_style = "unicode",
        git_services = {
          ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
          ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
          ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
        },
        telescope_sorter = function()
          return require("telescope").extensions.fzf.native_fzf_sorter()
        end,
        remember_settings = true,
        use_per_project_settings = true,
        ignored_settings = {
          "NeogitPushPopup--force-with-lease",
          "NeogitPushPopup--force",
          "NeogitPullPopup--rebase",
          "NeogitCommitPopup--allow-empty",
          "NeogitRevertPopup--no-edit",
        },
        highlight = {
          italic = true,
          bold = true,
          underline = true,
        },
        use_default_keymaps = true,
        auto_refresh = true,
        sort_branches = "-committerdate",
        notification_icon = "✓",
        use_magit_keybindings = false,
        console_timeout = 2000,
        commit_popup = {
          kind = "split",
        },
        commit_editor = {
          kind = "tab",
        },
        commit_select_view = {
          kind = "tab",
        },
        commit_view = {
          kind = "vsplit",
          verify_commit = os.execute("which gpg") == 0,
        },
        log_view = {
          kind = "tab",
        },
        rebase_editor = {
          kind = "auto",
        },
        reflog_view = {
          kind = "tab",
        },
        merge_editor = {
          kind = "auto",
        },
        tag_editor = {
          kind = "auto",
        },
        preview_buffer = {
          kind = "split",
        },
        popup = {
          kind = "split",
        },
        signs = {
          section = { ">", "v" },
          item = { ">", "v" },
          hunk = { "", "" },
        },
        integrations = {
          telescope = true,
          diffview = true,
        },
        sections = {
          untracked = {
            folded = false,
            hidden = false,
          },
          unstaged = {
            folded = false,
            hidden = false,
          },
          staged = {
            folded = false,
            hidden = false,
          },
          stashes = {
            folded = true,
            hidden = false,
          },
          unpulled = {
            folded = true,
            hidden = false,
          },
          unmerged = {
            folded = false,
            hidden = false,
          },
          recent = {
            folded = true,
            hidden = false,
          },
        },
        mappings = {
          finder = {
            ["<cr>"] = "Select",
            ["<c-c>"] = "Close",
            ["<esc>"] = "Close",
            ["<c-n>"] = "Next",
            ["<c-p>"] = "Previous",
            ["<down>"] = "Next",
            ["<up>"] = "Previous",
            ["<tab>"] = "MultiselectToggleNext",
            ["<s-tab>"] = "MultiselectTogglePrevious",
            ["<c-j>"] = "NOP",
          },
          status = {
            ["q"] = "Close",
            ["I"] = "InitRepo",
            ["1"] = "Depth1",
            ["2"] = "Depth2",
            ["3"] = "Depth3",
            ["4"] = "Depth4",
            ["<tab>"] = "Toggle",
            ["x"] = "Discard",
            ["s"] = "Stage",
            ["S"] = "StageUnstaged",
            ["<c-s>"] = "StageAll",
            ["u"] = "Unstage",
            ["U"] = "UnstageStaged",
            ["$"] = "CommandHistory",
            ["Y"] = "YankSelected",
            ["<c-r>"] = "RefreshBuffer",
            ["<enter>"] = "GoToFile",
            ["<c-v>"] = "VSplitOpen",
            ["<c-x>"] = "SplitOpen",
            ["<c-t>"] = "TabOpen",
            ["{"] = "GoToPreviousHunkHeader",
            ["}"] = "GoToNextHunkHeader",
          },
        },
      })
      
      vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit", noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gC", "<cmd>Neogit commit<cr>", { desc = "Neogit commit", noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gP", "<cmd>Neogit push<cr>", { desc = "Neogit push", noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gl", "<cmd>Neogit pull<cr>", { desc = "Neogit pull", noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "<leader>gB", "<cmd>Neogit branch<cr>", { desc = "Neogit branches", noremap = true, silent = true })
    end,
  },
}