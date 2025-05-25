return function(ctx)
    local s = ctx.s
    local i = ctx.i
    local fmt = ctx.fmt
    local rep = ctx.rep

    return {
        s("fab",
            fmt("{} :: {} -> {}\n{} {} = {}",
                { i(1, "f"), i(2, "a"), i(3, "b"), rep(1), i(4), i(5) })
        ),
        s("wrap",
            fmt("data {} = {} a", { i(1), rep(1) })
        )
    }
end
