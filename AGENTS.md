# Agent Guidelines for Neovim Configuration

## Project Overview
Neovim configuration using **lazy.nvim** plugin manager, written entirely in **Lua**.
No build/test pipeline — changes take effect on Neovim restart.

---

## Build / Lint / Test Commands

### No Traditional Build System
There are no build, test, or CI commands. To validate changes:
- **Restart Neovim** — all Lua is sourced on startup
- **`:checkhealth`** — run inside Neovim to diagnose plugin/LSP issues
- **`:Lazy`** — open plugin manager UI (install/update/sync plugins)
- **`:Lazy sync`** — install missing + remove unused plugins
- **`:Mason`** — manage LSP servers and formatters
- **`:LspInfo`** / **`:NullLsInfo`** — inspect active LSP/formatter state

### Linting Lua (stylua)
```bash
# Format a single Lua file
stylua lua/config/plugins/telescope.lua

# Format all Lua files
stylua lua/
```
`stylua` is installed via Mason and used as the Lua formatter through none-ls.

### Available Formatters/Linters (via none-ls / Mason)
| Tool        | Language(s)          |
|-------------|----------------------|
| `stylua`    | Lua                  |
| `black`     | Python               |
| `prettierd` | JS, TS, JSON, YAML, Markdown |
| `shfmt`     | Shell (bash/sh)      |
| `sqlfluff`  | SQL                  |
| `yamllint`  | YAML                 |
| `checkmake` | Makefiles            |

---

## Directory Structure

```
~/.config/nvim/
├── init.lua                   # Entry point: loads user/* then config.lazy
├── after/
│   └── plugin/
│       └── defaults.lua       # Utility module (save_and_quit); on package.path
├── lua/
│   ├── config/
│   │   ├── lazy.lua           # Bootstrap + setup lazy.nvim
│   │   └── plugins/           # One file per plugin or plugin group
│   │       ├── colorscheme.lua
│   │       ├── git.lua
│   │       ├── indentline.lua
│   │       ├── lualine.lua
│   │       ├── markdown.lua
│   │       ├── misc.lua
│   │       ├── nvimtree.lua
│   │       ├── telescope.lua
│   │       ├── treesitter.lua
│   │       ├── whichkey.lua
│   │       └── lsp/           # LSP-specific plugin configs
│   │           ├── autocomplete.lua
│   │           ├── misc.lua
│   │           ├── none-ls.lua
│   │           └── servers.lua
│   └── user/                  # User settings (no plugin code)
│       ├── autocommands.lua
│       ├── keymaps.lua
│       ├── options.lua
│       └── variables.lua
```

---

## Code Style

### Lua Formatting
- **Indentation**: Tabs (`expandtab = true`, `tabstop = 4`, `shiftwidth = 4`)
- **Strings**: Double quotes — `"value"` not `'value'`
- **Trailing commas**: Include in multi-line tables
- **Line length**: No hard limit; keep lines readable
- **Comments**: `--` for inline/single-line; block logic with section headers

### Naming Conventions
- **Local variables**: `snake_case` (e.g., `local hide_in_width`, `local null_ls`)
- **Augroup names**: `PascalCase` descriptive names (e.g., `GeneralSettings`, `Git`, `LSP`)
- **Module returns**: Always return a table from plugin files
- **Plugin alias**: Short local alias for required modules
  ```lua
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  ```

### Imports / require
- Always `local`-alias requires at the top of `config = function()` blocks
- Use `pcall` for optional/extension requires:
  ```lua
  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "live_grep_args")
  ```
- Inline `require` is acceptable in keymap callbacks:
  ```lua
  "<cmd>lua require('gitsigns').preview_hunk()<cr>"
  ```

---

## Plugin Configuration Patterns

### Pattern 1: Simple opts (preferred for basic configs)
```lua
return {
    { "plugin/name", opts = {} },
}
```

### Pattern 2: opts as function (for extending defaults)
```lua
{
    "plugin/name",
    opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, { name = "lazydev" })
    end,
}
```

### Pattern 3: config function (for complex setup)
```lua
{
    "plugin/name",
    config = function()
        local plugin = require("plugin")
        plugin.setup({ ... })
    end,
}
```

### Common Plugin Spec Fields
- `dependencies` — list of required plugins (strings or spec tables)
- `event = "VimEnter"` — defer load until after UI
- `ft = "lua"` — load only for a specific filetype
- `build = ":TSUpdate"` — run on install/update
- `main = "module.name"` — module to call `.setup()` on when using `opts`
- `lazy = false` — force eager loading (use for colorscheme)
- `priority = 1000` — load order (use for colorscheme)

---

## LSP Configuration

### Capability Injection (always use blink.cmp)
```lua
local capabilities = require("blink.cmp").get_lsp_capabilities()
server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
```

### Adding a New LSP Server
Edit `lua/config/plugins/lsp/servers.lua`, add to the `servers` table:
```lua
local servers = {
    my_server = {
        settings = { ... },  -- optional overrides
    },
}
```
The server name is also auto-added to `mason-tool-installer` for automatic installation.

### Formatting via LSP
Format using `null-ls` client only (prevents double-formatting):
```lua
vim.lsp.buf.format({
    filter = function(client) return client.name == "null-ls" end,
    timeout_ms = 3000,
})
```

---

## Autocommands

Always use a named augroup with `{ clear = true }`:
```lua
local _my_group = vim.api.nvim_create_augroup("MyGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    desc = "Short description of what this does",
    group = _my_group,
    pattern = "lua",
    callback = function(event)
        -- use event.buf for buffer-local operations
    end,
})
```
- Prefix augroup locals with `_` (e.g., `_general_settings`, `_git`)
- Always provide a `desc` field
- Prefer `callback = function()` over `command = "..."` for complex logic

---

## Keymaps

### Global keymaps (`lua/user/keymaps.lua`)
```lua
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<leader>x", "<cmd>bdelete<CR>", opts)
```
- Leader key: `<Space>` (`vim.g.mapleader = " "`)
- Always pass `{ noremap = true, silent = true }` unless intentionally overriding
- Use `vim.tbl_deep_extend("force", opts, { expr = true })` for expr maps

### Plugin/buffer-local keymaps
```lua
vim.keymap.set("n", "<leader>x", function() ... end, {
    buffer = bufnr,
    desc = "Description shown in which-key",
})
```
- Always include `desc` for buffer-local maps (shows in which-key)
- Register grouped maps in `lua/config/plugins/whichkey.lua` under `spec`

---

## User Settings Files (`lua/user/`)

| File               | Purpose                                      |
|--------------------|----------------------------------------------|
| `options.lua`      | `vim.opt` settings via a local `options` table iterated with `for k, v in pairs()` |
| `keymaps.lua`      | Global keymaps; no plugin-specific binds     |
| `autocommands.lua` | All autocommands grouped by concern          |
| `variables.lua`    | `vim.g.*` globals (python path, plugin flags)|

---

## `after/plugin/` Directory

Files here are added to `package.path` in `init.lua`, so they can be `require`'d without a path prefix:
```lua
-- In whichkey.lua:
require("defaults").save_and_quit("single")
```
Modules in `after/plugin/` should return a table (`local M = {}; return M`).

---

## Error Handling

- Use `pcall()` for optional operations that may fail:
  ```lua
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_filesize then ... end
  ```
- Use `assert()` for programming errors with clear messages:
  ```lua
  assert(has_value(accepted_modes, mode), "Unknown mode " .. mode)
  ```
- Never silently swallow errors in `config = function()` blocks

---

## Key Plugins Reference

| Category        | Plugin(s)                                              |
|-----------------|--------------------------------------------------------|
| Plugin manager  | `folke/lazy.nvim`                                      |
| Colorscheme     | `folke/tokyonight.nvim` (style: moon, transparent)     |
| File tree       | `nvim-tree/nvim-tree.lua`                              |
| Fuzzy finder    | `nvim-telescope/telescope.nvim` + fzf + live-grep-args |
| Status line     | `nvim-lualine/lualine.nvim`                            |
| Syntax          | `nvim-treesitter/nvim-treesitter`                      |
| LSP             | `neovim/nvim-lspconfig` + Mason ecosystem              |
| Completion      | `saghen/blink.cmp` + `L3MON4D3/LuaSnip`               |
| Formatting/Lint | `nvimtools/none-ls.nvim`                               |
| Git             | `lewis6991/gitsigns.nvim`, `tpope/vim-fugitive`        |
| Navigation      | `theprimeagen/harpoon`, `easymotion/vim-easymotion`    |
| Keybind help    | `folke/which-key.nvim`                                 |
