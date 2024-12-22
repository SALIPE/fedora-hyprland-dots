return {
    "nvim-neo-tree/neo-tree.nvim",
     branch = "v3.x",
     dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-tree/nvim-web-devicons",
         "MunifTanjim/nui.nvim",    
     },
    config = function()
        require("neo-tree").setup({
            enable_git_status = true,
            window={
                position= "right"
            },
            filesystem = {
                filtered_items = {
                    visible = true, 
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
            }
        })
        --vim.keymap.set('n', '<C-b>', ':Neotree filesystem reveal right<CR>', {})
        vim.keymap.set('n', '<C-b>', ':Neotree toggle<CR>', {})
        vim.cmd("Neotree filesystem reveal")
    end
 }
