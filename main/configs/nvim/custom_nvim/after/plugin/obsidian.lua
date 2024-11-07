require("obsidian").setup({
    workspaces = {
        {
            name = "lit",
            path = "~/Documents/obsidian/main/literature notes/",
        },
        {
            name = "currentProject",
            path = _G.obsidian_project,
        },
        {
            name = "course",
            path = "~/Documents/obsidian/main/course work/",
        },
    },
    notes_subdir = _G.obsidian_subdir,
    daily_notes = {
        folder = "daily notes"
    },
    completion = {
        nvim_cmp = true,
        min_chars = 1,
    },
    mappings = {
        -- Toggle check-boxes.
        ["<leader>ch"] = {
            action = function()
                return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<CR>"] = {
            action = function()
                return require("obsidian").util.smart_action()
            end,
            opts = { buffer = true, expr = true },
        }
    },
    new_notes_location = "notes_subdir",
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
            end
        end
        return tostring(os.time()) .. "-" .. suffix
    end,
    ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    ---@return string|obsidian.Path The full path to the new note.
    note_path_func = function(spec)
        -- This is equivalent to the default behavior.
        local path = spec.dir / tostring(spec.id)
        return path:with_suffix(".md")
    end,
    preferred_link_style = "wiki",
    templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
    },
    follow_url_func = function (url)
        vim.fn.jobstart({"xdg-open", url})
    end,
    picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        mappings = {
            -- Create a new note from your query.
            new = "<C-x>",
            -- Insert a link to the selected note.
            insert_link = "<C-l>",
        },
    },
    attachments = {
        img_folder = "~/Documents/obsidian/main/assets/images",
        ---@param client obsidian.Client
        ---@param path obsidian.Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
            path = client:vault_relative_path(path) or path
            return string.format("![%s](%s)", path.name, path)
        end,
    },

})

vim.api.nvim_set_keymap('n', '<leader><CR>', ':ObsidianFollowLink<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gf', ':ObsidianBacklinks<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>ch', function()
    require("obsidian").util.toggle_checkbox()
end, {noremap = true, silent = true})
