local fid_status, fid = pcall(require, "fidget")
if not fid_status then return end

fid.setup { window = { blend = 0 } }
