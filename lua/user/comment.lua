local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

-- Vaguely following nvim-ts-context-commentstring guide for Comment.nvim integration
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
-- Copying: https://github.com/LunarVim/Neovim-from-scratch/blob/0fd9cefa9b01cdb5cd89b394ed5b54b3c4f5eaf1/lua/user/comment.lua
comment.setup {
  pre_hook = function(ctx)
    local U = require "Comment.utils"

    local status_utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
    if not status_utils_ok then
      return
    end

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = utils.get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = utils.get_visual_start_location()
    end

    local status_internals_ok, internals = pcall(require, "ts_context_commentstring.internals")
    if not status_internals_ok then
      return
    end

    return internals.calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    }
  end,
}
