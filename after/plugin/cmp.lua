local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup ({
    experimental = {
        ghost_text = true,
    },
    formatting = {
        format = lspkind.cmp_format(),
    },
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = true  }),
        ['<Up>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end),
        ['<Down>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item()
            end
        end),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        {
            name = 'buffer',
            keyword_length = 3,
        },
    }),
})
