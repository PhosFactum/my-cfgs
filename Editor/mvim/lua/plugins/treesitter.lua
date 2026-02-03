require'nvim-treesitter.configs'.setup({
    ensure_installed = { "lua", "bash", "zsh", "go", "python", "java", "javascript", "c", "vim", "markdown", "vimdoc" },

    -- For async install, for opening other files and for hightlight
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
})
