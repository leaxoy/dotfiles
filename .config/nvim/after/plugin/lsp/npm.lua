local npm_status, npm = pcall(require, "package-info")
if not npm_status then return end

npm.setup {}
