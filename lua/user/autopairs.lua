local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

npairs.setup({
  -- Treesitter rules
  check_ts = true,
  -- Per language, disable in some syntax tree groups
  -- `lua = {"string"}`
  -- `javascript = {"template_string"}`
  -- `java = false`
  ts_config = {},
  -- Disable autopairs when filetype in this table
  -- Check the current ft with `:echo &ft`
  disable_filetype = { "TelescopePrompt" },
  enable_bracket_in_quote = false,
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "Search",
    highlight_grey = "Comment",
  },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
