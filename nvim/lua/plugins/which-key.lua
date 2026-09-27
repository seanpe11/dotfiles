return {
  "folke/which-key.nvim",
  opt = function(_, opts)
    local layout = require("lazyvim.util").layout

    opts.win = layout.bottom(0.8)
    return opts
  end,
}
