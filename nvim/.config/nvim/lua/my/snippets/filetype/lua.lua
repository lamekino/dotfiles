return function(ctx)
    local s = ctx.s
    local i = ctx.i
    local fmt = ctx.fmt
    local rep = ctx.rep

    return {
        s("req",
            fmt("local {} = require(\"{}\")",
                { i(1), rep(1) })
        ),
        s("lf",
            fmt("local {} = function({})\n    {}\nend",
                { i(1), i(2), i(3, "return") })
        )
    }
end
