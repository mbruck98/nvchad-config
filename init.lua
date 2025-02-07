vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("CursorHold",
{
    callback = function()
		vim.cmd [[ echon '']]
	end
})

vim.api.nvim_create_user_command('DapUiClose',
    function()
        require('dapui').close()
    end,{}
)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup(
{
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
    },
    {
        import = "plugins"
    },
}, lazy_config)

require("transparent").setup(
{
    -- table: default groups
    groups =
    {
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
        'EndOfBuffer',
    },
    -- table: additional groups that should be cleared
    extra_groups =
    {
        "NormalFloat",
        "Normal",
        "NvimTreeNormal",
        "NvimTreeNormalFloat",
     	"NvimTreeNormalNC",
    },
    -- table: groups you don't want to clear
    exclude_groups = {},
    -- function: code to be executed after highlight groups are cleared
    -- Also the user event "TransparentClear" will be triggered
    on_clear = function() end,
})

local dap = require('dap')

dap.adapters.cppdbg =
{
    name = 'cppdbg',
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7',
}
dap.configurations.cpp =
{
    {
        name = "Launch",
        type = "cppdbg",
        request = "launch",
        args = function()
            local args_string = vim.fn.input("Executable arguments: ")
            return vim.split(args_string, " ")
        end,
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        runInTerminal = true,
        setupCommands =
        {
            {
                text = '-enable-pretty-printing',
                description =  'enable pretty printing',
                ignoreFailures = false
            },
        },
    },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.h = dap.configurations.cpp
dap.configurations.hpp = dap.configurations.cpp

require("dapui").setup()

require("hover").setup(
{
    init = function()
	    require("hover.providers.lsp")
    end,
	preview_opts =
    {
	    border = "single",
    },
	-- Whether the contents of a currently open hover window should be moved
	-- to a :h preview-window when pressing the hover keymap.
    preview_window = false,
    title = false,
    mouse_providers =
    {
	    "LSP",
    },
	mouse_delay = 500,
})

require("which-key").setup({})

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)


