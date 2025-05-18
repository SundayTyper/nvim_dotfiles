local K = {}

K.mappings = {
  ["n"] = { -- Normal mode mappings
    dd = function() -- dd from empty lines go to the blackhole
      if vim.fn.getline(".") == "" then
        return '"_dd'
      end
      return "dd"
    end,
  },
  ["i"] = { -- Insert mode mappings
  },
}

return K
