local wk = require("which-key")

wk.setup({
    preset = "modern",
    win = {
        border = "single",
    },
})

-- Register prefix labels
wk.add({
    { "<leader>c", group = "Code/Quickfix" },
    { "<leader>d", group = "Delete (Void)/Doge" },
    { "<leader>g", group = "Git" },
    { "<leader>l", group = "LSP" },
    { "<leader>m", group = "Make/Misc" },
    { "<leader>r", group = "Reload/Replace" },
    { "<leader>s", group = "Search/Replace" },
    { "<leader>y", group = "Yank (OSC)" },
})