local M = {}

M.autofmt_disable_list = {}

M.disable = function(self, lsp_name)
    self.autofmt_disable_list[lsp_name] = true
end

M.callback = function(self)
    return function()
        vim.lsp.buf.format {
            filter = function(c)
                return self.autofmt_disable_list[c.name] == nil
            end
        }
    end
end

return M
