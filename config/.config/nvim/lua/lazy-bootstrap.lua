-- Bootstrap lazy.nvim
--
-- supply chain risk 低減のため、lazy.nvim 本体も lazy-lock.json に記録された
-- commit に固定する (ADR-0020)。--branch=stable はタグが可動なので使わない。
-- pin の情報源は lazy-lock.json に一本化し、ここにはハッシュを直書きしない。
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json"
  local lock = vim.json.decode(table.concat(vim.fn.readfile(lockfile), "\n"))
  local commit = lock["lazy.nvim"].commit
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
  vim.fn.system({ "git", "-C", lazypath, "checkout", commit })
end
vim.opt.rtp:prepend(lazypath)
