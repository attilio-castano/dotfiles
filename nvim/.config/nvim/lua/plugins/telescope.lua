return {
  {
    "nvim-telescope/telescope.nvim",
    -- plenary is mandatory; fzf-native is optional but highly recommended
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- super-fast native sorter that overrides the built-in Lua one
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",   -- requires build tools but dramatically speeds things up
        cond  = vim.fn.executable("make") == 1, -- only if make is available
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    },
    config = function()
      local telescope = require("telescope")
      local ignore    = require("plugins.telescope_ignore")

      -- Detect missing external tools early and warn only once per session.
      local lacks_rg = vim.fn.executable("rg") == 0
      local lacks_fd = vim.fn.executable("fd") == 0 and vim.fn.executable("fdfind") == 0
      if lacks_rg or lacks_fd then
        local missing = {}
        if lacks_rg then table.insert(missing, "ripgrep (rg)") end
        if lacks_fd then table.insert(missing, "fd") end
        vim.schedule(function()
          vim.notify(
            "Telescope: external binaries missing – " .. table.concat(missing, ", ") ..
              "\nInstall them for the best search experience.",
            vim.log.levels.WARN,
            { title = "Telescope" }
          )
        end)
      end

      telescope.setup {
        defaults = {
          file_ignore_patterns = ignore.file_ignore_patterns,

          -- Always show the full relative path but keep it short when possible
          path_display = { "smart" },

          -- If fd is present use it instead of the built-in file finder
          find_command = (not lacks_fd) and { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix" } or nil,
        },

        pickers = {
          -- Show hidden files too but still honour ignore patterns
          find_files = { hidden = true },
        },

        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- smart_case | ignore_case | respect_case
          },
        },
      }

      -- Load the fzf extension if the plugin is present (built successfully)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
