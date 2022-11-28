local gitsigns_status, gitsigns = pcall(require, "gitsigns")

if gitsigns_status then gitsigns.setup {} end

local diff_status, diff = pcall(require, "diffview")
if diff_status then diff.setup {} end
