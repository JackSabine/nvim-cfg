local status_ok_pbreakpt, pbreakpt = pcall(require, "persistent-breakpoints")
if not status_ok_pbreakpt then
  return
end

pbreakpt.setup({
  load_breakpoints_event = { "BufReadPost" },
})
