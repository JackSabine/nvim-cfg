local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
  return
end

indent_blankline.setup({
  enabled = true,
  debounce = 100,
  indent = { char = "▏" },
  scope = {
    enabled = true,
    char = "▏",
    show_start = true,
    show_end = false,
    exclude = {
      language = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
      },
    },
  },
})
