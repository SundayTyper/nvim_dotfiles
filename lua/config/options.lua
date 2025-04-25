local O = {} -- create a module table

O.options = {
  -- Enable line numbers
  number = true,
  relativenumber = true,

  -- Enable line wrapping by default
  wrap = true,
  wrapmargin = 100,
  ruler = true,

  -- Search settings
  incsearch = true, -- Incremental search
  hlsearch = true, -- Highlight search results
  ignorecase = true, -- Case-insensitive search
  smartcase = true, -- Case-sensitive search if there are uppercase characters

  -- Other useful settings
  backspace = "indent,eol,start", -- Allow backspacing over indent, EOL, and start of line
  showcmd = true, -- Show typed commands
  wildmenu = true, -- Enable command-line completion
}

O.commands = {
  syntax_on = "syntax on",
  ruler_colour = "highlight ColorColumn guibg=darkblue",
}

return O
