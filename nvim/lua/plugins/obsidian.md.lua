return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  keys = {
    { "<leader>oo", ":Obsidian ", desc = "Obsidian Command..." },
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Note" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search Vault (Grep)" },
    { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find Note (File)" },
    { "<leader>oj", "<cmd>ObsidianFollowLink<cr>", desc = "Follow Link Under Cursor" },
    { "<leader>ok", "<cmd>ObsidianBacklinks<cr>", desc = "Show Backlinks" },
    { "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Today's Daily Note" },
  },
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    -- Required by obsidian-query.nvim: Dataview queries read from this cache.
    cache = { enabled = true },

    workspaces = {
      {
        name = "personal",
        path = "~/Documents/PepeVault/",
      },
    },

    -- Filenames are the title, verbatim. The plugin default is `zettel_id`,
    -- which produces `1758734400-QXZR`; `title_id` produces `lowercase-dashes`.
    -- Neither matches this vault, where notes are named the way they read:
    -- "Poker Trainer App.md", "Cover Letter - 24981 Research IT.md".
    -- The id in frontmatter then matches the filename, which is the existing
    -- convention throughout the vault.
    note_id_func = function(title)
      if type(title) == "string" then
        local name = vim.trim(title)
        -- Only strip what a filename genuinely cannot contain.
        name = name:gsub("[/\\:%z]", "-")
        if name ~= "" then
          return name
        end
      end
      -- Untitled notes still need something unique.
      return require("obsidian.builtin").zettel_id()
    end,

    -- Folder structure is the organising principle here, not tags. New notes
    -- land in the directory you are already in. `notes_subdir` is deliberately
    -- unset: it was pointed at "02 - Projects", a ghost directory the plugin
    -- kept recreating, and any fixed subdir fights the folder-as-status layout.
    new_notes_location = "current_dir",

    templates = {
      folder = "99-Meta/zz-Templates",
    },

    daily_notes = {
      -- Canonical folder. "01-Journal/A-Daily" is the known Syncthing duplicate
      -- and must never be written into.
      folder = "01-Journal/A - Daily",
      date_format = "%Y-%m-%d",
      -- Resolved against templates.folder above.
      template = "DailyJournal.md",
    },

    -- Matches the vault rule: every note carries id, aliases, tags, in that order.
    frontmatter = {
      enabled = true,
      sort = { "id", "aliases", "tags" },
    },
  },
}
