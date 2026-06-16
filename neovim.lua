return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = {
        bg         = "#0a0f1c",
        dark_bg    = "#080e1a",
        darker_bg  = "#060a14",
        lighter_bg = "#0e1628",

        fg         = "#eaf3ff",
        dark_fg    = "#8a97ad",
        light_fg   = "#d8e4f2",
        bright_fg  = "#f2f7ff",
        muted      = "#2a3550",

        red        = "#1573b8",
        yellow     = "#e0b052",
        orange     = "#8f9fe0",
        green      = "#8ab84a",
        cyan       = "#19c4d8",
        blue       = "#1ea7ff",
        purple     = "#6f7fc8",
        brown      = "#223252",

        bright_red    = "#1ea7ff",
        bright_yellow = "#ffcf6b",
        bright_green  = "#a6d066",
        bright_cyan   = "#5fe0ee",
        bright_blue   = "#5fc4ff",
        bright_purple = "#8f9fe0",

        accent               = "#1ea7ff",
        cursor               = "#1ea7ff",
        foreground           = "#eaf3ff",
        background           = "#0a0f1c",
        selection            = "#0e1628",
        selection_foreground = "#f2f7ff",
        selection_background  = "#1573b8",
      },
    },
    -- set up hot reload
    config = function(_, opts)
      require("aether").setup(opts)
      vim.cmd.colorscheme("aether")
      require("aether.hotreload").setup()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
