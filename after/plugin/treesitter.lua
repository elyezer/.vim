local ensure_installed = {
  "bash",
  "lua",
  "python",
  "toml",
  "yaml",
}

require('nvim-treesitter').install(ensure_installed)

vim.api.nvim_create_autocmd('FileType', {
  pattern = ensure_installed,
  callback = function()
    vim.treesitter.start()
  end,
})

require('nvim-treesitter-textobjects').setup {
  select = {
    lookahead = true,
  },
}

local select = require('nvim-treesitter-textobjects.select')
local textobjects_keymaps = {
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["ac"] = "@class.outer",
  ["ic"] = "@class.inner",
  ["aa"] = "@parameter.outer",
  ["ia"] = "@parameter.inner",
}

for keymap, query_string in pairs(textobjects_keymaps) do
  vim.keymap.set({ "x", "o" }, keymap, function()
    select.select_textobject(query_string, "textobjects")
  end)
end
