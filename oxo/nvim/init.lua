require("lilcumstain")

function GetHighlightGroup()
    local line = vim.fn.line('.')
    local col = vim.fn.col('.')
    local synID = vim.fn.synID(line, col, 1)
    print("Syntax ID:", synID)
    local highlight_group = vim.fn.synIDattr(synID, 'name')
    print("Highlight Group:", highlight_group)
end

