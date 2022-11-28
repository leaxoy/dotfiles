local ide_status, ide = pcall(require, "ide")

if not ide_status then return end

local explorer = require "ide.components.explorer"
local outline = require "ide.components.outline"
local callhierarchy = require "ide.components.callhierarchy"
local timeline = require "ide.components.timeline"
local terminal = require "ide.components.terminal"
local terminalbrowser = require "ide.components.terminal.terminalbrowser"
local changes = require "ide.components.changes"
local commits = require "ide.components.commits"
local branches = require "ide.components.branches"
local bookmarks = require "ide.components.bookmarks"

ide.setup {
  icon_set = "codicon",
  panel_groups = {
    explorer = {
      outline.Name,
      explorer.Name,
      bookmarks.Name,
      callhierarchy.Name,
      terminalbrowser.Name,
    },
    terminal = { terminal.Name },
    git = { changes.Name, commits.Name, timeline.Name, branches.Name },
  },
}
