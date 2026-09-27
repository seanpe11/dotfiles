-- Dataview queries rendered inside Neovim.
-- Requires obsidian.nvim with cache enabled (set in obsidian.md.lua).
-- Supports TABLE / LIST / TASK / CALENDAR and inline `= expr`, with
-- FROM / WHERE / SORT / GROUP BY / FLATTEN / LIMIT.
-- Does NOT support dataviewjs or any JavaScript expressions.
return {
  {
    "dpezto/obsidian-query.nvim",
    ft = "markdown",
    opts = {
      picker = { style = "rich" },
    },
  },
  {
    -- render-markdown.nvim is already configured by LazyVim; extend its opts
    -- rather than replacing them.
    "MeanderingProgrammer/render-markdown.nvim",
    opts = function(_, opts)
      opts.custom_handlers = opts.custom_handlers or {}
      opts.custom_handlers.markdown = require("obsidian-query").handler
      opts.custom_handlers.markdown_inline = require("obsidian-query.inline").handler
    end,
  },
}
