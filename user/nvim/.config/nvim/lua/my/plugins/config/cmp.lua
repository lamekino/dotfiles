local cmp = require("cmp")
local luasnip = require("luasnip")

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
})
