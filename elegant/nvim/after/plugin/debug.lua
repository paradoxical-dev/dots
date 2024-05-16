require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = {
        "python",
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
dap.configurations.html = { -- change this to javascript if needed
    {
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

dap.configurations.javascript = { -- change this to javascript if needed
    {
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

dap.configurations.typescript = { -- change to typescript if needed
    {
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

dap.configurations.javascriptreact = { -- change this to javascript if needed
    {
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

dap.configurations.typescriptreact = { -- change to typescript if needed
    {
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

-- UI --
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
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
