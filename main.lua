local compiler = require("compiler")

local text = "a = 1 + 2 + len(dictionary.word1234)"
local tokens = compiler.lexer.lex(text)
for i = 1, #tokens do
  print(tokens[i].type, tokens[i].value)
end

--[[ 
  OUTPUT:
id      a
op      =
num     1
op      +
num     2
op      +
id      len
op      (
id      dictionary
op      .
id      word1234
op      )
]]