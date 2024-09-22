require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = {
        -- "python",
        "chrome",
        "node2",
        "bash",
        "dart",
        "javadbg",
        "cppdbg",
    },
    handlers = {
        function(config)
            require('mason-nvim-dap').default_setup(config)
        end,
    },
})
require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")

-- CHROME --
dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {"~/.local/share/nvim/mason/packages/chrome-debug-adapter/chrome-debug-adapter"}
}

dap.configurations.html = {
    {
        name = "Chrome",
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 3000,
        webRoot = "${workspaceFolder}"
    }
}

dap.configurations.javascript = {
    {
        name = "Chrome",
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 3000,
        webRoot = "${workspaceFolder}"
    }
}

dap.configurations.typescript = {
    {
        name = "Chrome",
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 3000,
        webRoot = "${workspaceFolder}"
    }
}

-- NODE2 --
dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = {"/home/mosus/.local/share/nvim/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"},
}

dap.configurations.javascript = {
    {
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
    },
    {
        type = "node2",
        request = "attach",
        processId = require'dap.utils'.pick_process,
        cwd = vim.fn.getcwd(),
    }
}

dap.configurations.typescript = {
    {
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
    },
    {
        type = "node2",
        request = "attach",
        processId = require'dap.utils'.pick_process,
        cwd = vim.fn.getcwd(),
    }
}

-- UI --
dap.listeners.after.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end

-- KEYMAPS --
vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
vim.keymap.set("n", "<leader>dc", dap.continue, {})
vim.api.nvim_set_keymap('n', '<leader>du', '<cmd>lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
