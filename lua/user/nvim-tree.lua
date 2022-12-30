local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvimtree.setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    side = "left",
    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        -- { key = "v", cb = tree_cb "vsplit" },
        { key = { "<Esc>", "q" }, cb = tree_cb "close" },
        { key = "u", action = "dir_up" },
      },
    },
  },
  filters = {
    dotfiles = true,
  },

  update_focused_file = {
    enable = true,
    update_root = true,
  },
  renderer = {
    group_empty = true,
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "M",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "D",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
})

