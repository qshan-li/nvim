return function()
	require("mini.files").setup({
		mappings = {
			go_in = "l",
			go_in_plus = "<CR>",
			close = "<Esc>",
			synchronize = "<A-CR>",
		},
	})

	local function copy_to_clipboard(text, description)
		vim.fn.setreg("+", text)
		vim.fn.setreg("*", text)
		vim.fn.setreg('"', text)
		if vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
			local osc52 = "\027]52;c;" .. vim.fn.system("base64 -w0", text):gsub("\n", "") .. "\027\\"
			io.stdout:write(osc52)
			io.stdout:flush()
		end
		if description then
			vim.notify(description, vim.log.levels.INFO)
		end
	end

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesActionDone",
		callback = function(args)
			local action = args.data.action
			if action == "open" then
				require("mini.files").close()
			end
		end,
	})

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			local buf_id = args.data.buf_id
			vim.keymap.set("n", "<C-c>", require("mini.files").close, { buffer = buf_id, desc = "Close mini.files" })

			vim.keymap.set("n", "@", function()
				local path = (require("mini.files").get_fs_entry() or {}).path
				if path == nil then
					return vim.notify("Cursor is not on valid entry")
				end
				vim.fn.chdir(vim.fs.dirname(path))
				vim.notify("cwd: " .. vim.fn.getcwd())
			end, { buffer = buf_id, desc = "Set cwd" })

			vim.keymap.set("n", "gy", function()
				local path = (require("mini.files").get_fs_entry() or {}).path
				if path == nil then
					return vim.notify("Cursor is not on valid entry")
				end
				vim.fn.setreg(vim.v.register, path)
				vim.notify("Yanked: " .. path)
			end, { buffer = buf_id, desc = "Yank path" })

			vim.keymap.set("n", "<leader>rr", function()
				local path = (require("mini.files").get_fs_entry() or {}).path
				if path == nil then
					return vim.notify("Cursor is not on valid entry")
				end
				copy_to_clipboard(path)
			end, { buffer = buf_id, desc = "Copy absolute path" })

			vim.keymap.set("n", "<leader>rn", function()
				local path = (require("mini.files").get_fs_entry() or {}).path
				if path == nil then
					return vim.notify("Cursor is not on valid entry")
				end
				local dir_path = vim.fs.dirname(path)
				copy_to_clipboard(dir_path, "Copied directory path: " .. dir_path)
			end, { buffer = buf_id, desc = "Copy parent directory path" })

			vim.keymap.set("n", "<leader>rd", function()
				local path = (require("mini.files").get_fs_entry() or {}).path
				if path == nil then
					return vim.notify("Cursor is not on valid entry")
				end
				local dir_path = vim.fn.isdirectory(path) == 1 and path or vim.fs.dirname(path)
				copy_to_clipboard(dir_path, "Copied directory path: " .. dir_path)
			end, { buffer = buf_id, desc = "Copy directory path" })
		end,
	})
end
