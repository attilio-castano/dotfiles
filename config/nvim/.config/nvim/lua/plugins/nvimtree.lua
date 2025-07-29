
return {
    {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- 🔑 Load immediately so it can replace netrw on `nvim .`
    lazy = false,                 -- do NOT lazy‑load; start with Neovim
    priority = 1000,              -- load early (before other UI plugins)
    -- Disable netrw *before* the plugin starts
    init = function()
        vim.g.loaded_netrw       = 1
        vim.g.loaded_netrwPlugin = 1
    end,
    keys = {
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Tree" },
    },
    config = function()
        local function my_on_attach(bufnr)
            local api = require("nvim-tree.api")

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

        api.config.mappings.default_on_attach(bufnr)

            local function map(key, func, desc)
                vim.keymap.set('n', key, func, opts(desc))
            end

            -- Unmap the default '-' keybinding
            vim.keymap.del('n', '-', { buffer = bufnr })
            -- Disable 'q' to prevent accidental closing (use <leader>e instead)
            vim.keymap.del('n', 'q', { buffer = bufnr })

            -- Smart open: delegate to 'o' mapping (expand or open)
            map('l', function()
                vim.cmd('normal o')
            end, 'Smart Open')


            -- Smart close: collapse directory or go to parent with 'h'
            map('h', api.node.navigate.parent_close, 'Smart Close')
            map('v', api.node.open.vertical, 'Open: Vertical Split')
            map('s', api.node.open.horizontal, 'Open: Horizontal Split')
            map('t', api.node.open.tab, 'Open: New Tab')
            map('C', api.tree.change_root_to_node, 'Change Root to Node')
            -- Default parent directory
            map('-C', api.tree.change_root_to_parent, 'Up to Parent')
            -- Toggle hidden/dotfiles
            map('H', api.tree.toggle_hidden_filter,  'Toggle Dotfiles')
            map('z', api.tree.collapse_all, 'Collapse All')
        end

        require("nvim-tree").setup({
            hijack_netrw = true,
            disable_netrw = true,
            hijack_directories = {   -- auto‑open tree when `nvim .`
                enable = true,
                auto_open = true,
            },
            view = {
                width = 32,
            },
            renderer = { group_empty = true },
            git = { enable = true, ignore = false },
            auto_reload_on_write = true,
            filters = { dotfiles = false },
            update_focused_file = {
                enable = true,
                update_root = false, -- don't automatically chdir when opening files
            },
            actions = {
                change_dir = { enable = true, global = false },
                -- keep tree open when opening files (default behavior)
                open_file = { quit_on_open = false },
            },
            on_attach = my_on_attach,
        })
        end,
        },
}
