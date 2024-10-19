function RunC_CPP(file)
	-- local executable = vim.fn.expand("%:r") .. ".out"
	local executable = "a.out"
	local input_file = "input.txt"
	local output_file = "output.txt"

	vim.cmd("! '' >>" .. output_file)

	local compile_cmd = 'g++ "' .. file .. '" -o "' .. executable .. '"'
	local run_cmd = "timeout 4s  " .. './"' .. executable .. '" < "' .. input_file .. '" > "' .. output_file .. '"'

	-- print(compile_cmd)
	-- print(run_cmd)

	-- Compile the file
	local compile = vim.cmd("! " .. compile_cmd)

	-- Run the compiled file
	local run = vim.fn.system("! " .. run_cmd)

	-- local command = "echo 'Error in execution : '" .. run
	--
	-- if vim.v.shell_error ~= 0 then
	-- 	-- If there's an error, open a floating terminal to show error
	-- 	local Terminal = require("toggleterm.terminal").Terminal
	-- 	local term = Terminal:new({
	-- 		dir = "git_dir",
	-- 		cmd = command,
	-- 		hide_on_exit = false,
	-- 		close_on_exit = false,
	-- 		float_opts = {
	-- 			border = "curved",
	-- 			width = 80,
	-- 			height = 20,
	-- 			winblend = 3,
	-- 		},
	-- 	})
	-- 	term:open()
	-- end
end

function RunPython(file)
	local run_cmd = 'python3 "' .. file .. '"'
	vim.cmd("! " .. run_cmd)
end

function RunRust(file)
	local file = vim.fn.expand("%:p:h:h") -- Go up two directories from current directory where Cargo.toml file is located
	local run_cmd = 'cargo run --manifest-path "' .. file .. '/Cargo.toml"'
	vim.cmd("! " .. run_cmd)
end

function RunGo(file)
	local run_cmd = 'go run "' .. file .. '"'
	vim.cmd("! " .. run_cmd)
end

function RunJs(file)
	local run_cmd = 'node "' .. file .. '"'
	vim.cmd("! " .. run_cmd)
end

function RunLua(file)
	local run_cmd = 'lua "' .. file .. '"'
	vim.cmd("! " .. run_cmd)
end

-- Run code based on filetype
function RunCode()
	local filetype = vim.bo.filetype
	local file = vim.fn.expand("%:p")

	print("Running " .. file)
	if filetype == "c" or filetype == "cpp" then
		RunC_CPP(file)
	elseif filetype == "python" then
		RunPython(file)
	elseif filetype == "rust" then
		RunRust(file)
	elseif filetype == "go" then
		RunGo(file)
	elseif filetype == "javascript" or filetype == "typescript" then
		RunJs(file)
	elseif filetype == "lua" then
		RunLua(file)
	else
		print("File " .. file .. " of type " .. filetype .. " is not supported")
	end
end

-- Map Ctrl+B to compile and run code
vim.api.nvim_set_keymap("n", "<C-M-b>", ":lua RunCode()<CR>", { noremap = true, silent = true })
