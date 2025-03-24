local M = {}

--- @return string|nil
local function get_remote_url()
	local handle = io.popen("git config --get remote.origin.url")
	if handle == nil then
		return nil
	end

	local remote_url = handle:read("*a")
	handle:close()
	return remote_url
end

--- @return string|nil
local function get_branch_name()
	local handle = io.popen("git symbolic-ref HEAD")
	if handle == nil then
		return nil
	end

	local ref = handle:read("*a")
	handle:close()
	return ref:gsub("%s+", ""):gsub("refs/heads/", "")
end

M.open_current_in_gitlab = function()
	local remote_url = get_remote_url()
	if remote_url == nil then
		print("[gitlab-url.nvim] Could not read remote.origin.url")
		return
	end

	local branch_name = get_branch_name()
	if branch_name == nil then
		print("[gitlab-url.nvim] Could not read branch name")
		return
	end

	local current_file = vim.api.nvim_buf_get_name(0)
	local line_number = vim.api.nvim_win_get_cursor(0)[1]
	local line_suffix = line_number > 1 and ("\\#L" .. line_number) or ""

	local base_url, repo_name = string.match(remote_url, "(https://.+/)(.+)%.git")
	local file_path = string.match(current_file, ".+/" .. repo_name .. "/(.+)")

	local file_url = base_url .. repo_name .. "/-/blob/" .. branch_name .. "/" .. file_path .. line_suffix
	vim.cmd('!open "' .. file_url .. '"')
end

return M
