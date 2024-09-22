_G.obsidian_project= "~/Documents/obsidian/main/project notes/"
_G.obsidian_subdir = ""
_G.current_ws = "~/Documents/obsidian/main/"

local M = {}

function _G.set_project(new_path)
    local basePath = "~/Documents/obsidian/main/project notes/"
    if vim.fn.isdirectory(basePath .. new_path) == 1 then
        print("invalid directory: " .. basePath .. new_path)
        return
    end
    _G.obsidian_project = basePath .. new_path
    print("workspace set to " .. basePath .. new_path)
end

function _G.set_subdir(new_path)
    local current = _G.current_ws
    if vim.fn.isdirectory(current .. new_path) == 1 then
       print("invalid sub: " .. current .. new_path)
       return
    end
    _G.obsidian_subdir = current .. new_path
    print("subdir set to " .. current .. new_path)
end

vim.api.nvim_create_user_command('SetProject', function (opts)
    _G.set_project(opts.args)
end, { nargs = 1, complete = 'dir' })

vim.api.nvim_create_user_command('SetSub', function (opts)
    _G.set_subdir(opts.args)
end, { nargs = 1, complete = 'dir' })

function M.get_workspace()
   return {
       lit = "~/Documents/obsidian/main/literature notes/",
       course = "~/Documents/obsidian/main/course work/",
       currentProject = _G.obsidian_project
   }
end

function M.currentWS(ws_name)
    local workspaces = M.get_workspace()
    if workspaces[ws_name] then
        _G.current_ws = workspaces[ws_name]
        print("current ws changed: " .. ws_name .. "(" .. _G.current_ws .. ")")
        _G.obsidian_subdir = ""
    else
        print("ws not found " .. ws_name)
    end
end

vim.api.nvim_create_user_command("SetWorkspace", function (opts)
   local workspace_name = opts.args
   M.currentWS(workspace_name)
end, { nargs = 1 })

local float_win_id = nil

function M.on_buffer_create()
    local file_path = vim.fn.expand('%:p')
    local obsidian_path = os.getenv("HOME") .. "/Documents/obsidian/"
    local current_win = vim.api.nvim_get_current_win()

    if string.find(file_path, obsidian_path, 1, true) and current_win == 1000 then
        vim.cmd('bwipeout!')

        vim.schedule(function ()
            local float_win = M.createFloat()
            float_win_id = float_win
            vim.api.nvim_set_current_win(float_win)

            vim.cmd("edit " .. file_path)
        end)

        return
    end
end

function M.createFloat(file_path)
    local title = vim.fn.fnamemodify(file_path, ":t")

    local min_width = 90
    local win_width = math.max(math.floor(vim.o.columns * 0.65), min_width)
    local win_height = math.floor(vim.o.lines * 0.85)
    local row = math.floor((vim.o.lines - win_height) / 2)
    local col = math.floor((vim.o.columns - win_width) / 2)

    -- Create the floating window with the custom border
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        style = "minimal",
        border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'},
    })

    -- Set buffer options
    vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
    vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
    vim.api.nvim_buf_set_option(buf, 'wrap', true)
    vim.api.nvim_buf_set_option(buf, 'linebreak', true)

    vim.api.nvim_win_set_option(win, 'wrap', true)
    vim.api.nvim_win_set_option(win, 'linebreak', true)

    -- Set autocmd to handle window close
    vim.api.nvim_create_autocmd("WinClosed", {
        callback = function(args)
            if tonumber(args.match) == win then
                float_win_id = nil
            end
        end,
        buffer = buf,
    })

    return win
end

vim.cmd([[
    augroup InterceptBufferOpen
        autocmd!
        autocmd BufEnter * lua require('lilcumstain.obsidian_custom').on_buffer_create()
    augroup END
]])

return M
