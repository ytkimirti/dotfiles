# nvim

Requires Neovim **0.12+**. Plugins are managed by [lazy.nvim] and pinned in
`lazy-lock.json`.

```
init.lua              leader, then load order
lua/config/           options, keymaps, autocmds, commands, lazy bootstrap
lua/plugins/*.lua     one file per area, auto-imported by lazy
```

## Layout

| file                      | what's in it                                   |
| ------------------------- | ---------------------------------------------- |
| `plugins/colorscheme.lua` | gruvbox                                        |
| `plugins/treesitter.lua`  | treesitter (`main` branch) + textobjects       |
| `plugins/lsp.lua`         | lspconfig, mason, inc-rename, trouble, conform |
| `plugins/completion.lua`  | blink.cmp, LuaSnip                             |
| `plugins/telescope.lua`   | telescope + fzf-native + ui-select             |
| `plugins/editor.lua`      | nvim-tree, harpoon2, surround, autopairs       |
| `plugins/git.lua`         | gitsigns, fugitive                             |
| `plugins/ui.lua`          | lualine, bufferline, which-key, fidget         |

## LSP

Two ways a server gets turned on, both in `plugins/lsp.lua`:

1. **`MASON_SERVERS`** — installed and kept updated by mason
   (`lua_ls`, the TS server, `jsonls`, `cssls`, `html`, `bashls`).
   Anything else you `:MasonInstall` is enabled automatically next start.
2. **`IF_AVAILABLE`** — enabled only if the binary is already on `$PATH`,
   however it got there: brew, npm, cargo, `rustup component add
   rust-analyzer`, `go install .../gopls@latest`. Costs no disk and never
   warns about servers you don't have.

So mason is a convenience, not a requirement — install servers whichever way
you like and they get picked up. Where two servers cover the same filetype
(basedpyright/pyright) the list is nested and only the first one present
attaches, so diagnostics never double up.

### TypeScript: vtsls vs tsgo

`TS_SERVER` at the top of `plugins/lsp.lua` picks one. Measured on a real
project, 2026-08:

| | hover | def | refs | rename | doc symbols | code actions |
| --- | --- | --- | --- | --- | --- | --- |
| `vtsls` | ok | ok | 4 | ok | 3 | **19** |
| `tsgo` | ok | ok | 4 | ok | **5** | 1 |

[tsgo] is the native Go rewrite and is much faster. It does have the action
that matters most (*Add import from …*), but no refactorings — convert
export/import styles, extract function, and so on — and it still reports
itself as `7.0.0-dev`. Default is `vtsls`; change the one string to `'tsgo'`
if you'd rather have the fast one.

[tsgo]: https://github.com/microsoft/typescript-go

## Keys

Leader is `<Space>`. `;` and `:` are swapped.

### Movement / editing

| key             | does                                      |
| --------------- | ----------------------------------------- |
| `H` `L`         | start / end of line                       |
| `Q`             | replay the `q` macro                      |
| `<C-h>` `<C-l>` | previous / next buffer                    |
| `<A-j>` `<A-k>` | move line or selection down / up          |
| `<C-/>`         | toggle comment (built-in `gc`, no plugin) |
| `<F3>`          | toggle whitespace display                 |
| `<leader>z`     | zen mode                                  |
| `<leader>cd`    | cd to the current file's directory        |

### Text objects

`m` `"` · `n` `'` · `j` `()` · `u` `{}` — so `vim`, `can`, `diu`.

From treesitter: `f` function, `c` class, `a` parameter, `i` conditional,
`l` loop. `]f` `[f` jump between functions, `]a` `[a` between parameters.

### Telescope

| key          | picker              |
| ------------ | ------------------- |
| `<leader>o`  | find files          |
| `<leader>b`  | buffers             |
| `<leader>tg` | live grep           |
| `<leader>to` | recent files        |
| `<leader>tm` | marks               |
| `<leader>tk` | keymaps             |
| `<leader>tc` | colorschemes        |
| `<leader>th` | help tags           |
| `<leader>tb` | all builtin pickers |
| `<leader>gb` | git branches        |
| `<leader>gs` | git status          |

### LSP

| key          | does                                |
| ------------ | ----------------------------------- |
| `K`          | hover                               |
| `gd`         | definitions                         |
| `<leader>r`  | references                          |
| `<leader>i`  | implementations                     |
| `<leader>f`  | document symbols                    |
| `<leader>F`  | workspace symbols                   |
| `grn`        | rename (live preview)               |
| `<leader>ca` | code action                         |
| `<leader>lf` | format (conform, falls back to LSP) |
| `<leader>lh` | toggle inlay hints                  |
| `]e` `[e`    | next / previous diagnostic          |
| `]E` `[E`    | next / previous **error**           |
| `<leader>d`  | diagnostic float                    |
| `<leader>x…` | trouble (`xx` `xX` `xs` `xl` `xq`)  |

### Git (gitsigns)

`]c` `[c` next/previous hunk · `<leader>h` + `s`tage `r`eset `S`tage buffer
`u`ndo stage `R`eset buffer `p`review `b`lame `d`iff `D`iff HEAD~ · `ih` hunk
text object · `<leader>gg` fugitive.

### Files

`<C-n>` focus tree · `<leader>n` reveal current file · `<leader>a` harpoon add ·
`<leader>e` harpoon menu · `<leader>1`–`4` harpoon slots.

### Completion (blink.cmp)

`<C-Space>` open · `<CR>` accept (only when something is selected) ·
`<C-n>` `<C-p>` select · `<C-.>` `<C-,>` snippet jump / scroll docs ·
`<C-e>` dismiss · `<C-j>` `<C-k>` cycle snippet choices. `<Tab>` is left alone.

## Maintenance

```
:Lazy            plugin manager      :Lazy update  /  :Lazy restore
:Mason           LSP server manager
:TSUpdate        update parsers
:checkhealth     diagnose
:StartupTime     profile startup
```

[lazy.nvim]: https://github.com/folke/lazy.nvim
