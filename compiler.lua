local compiler = {}

local lexer = {}

function lexer.lex(text)
  local tokens = {}

  local pos = 1
  local length = #text
  
  while pos <= length do
    local char = text:sub(pos, pos)
    local char_type = ""
    if char:match("%s") then
      --space
      char_type = "%s"
    elseif char:match("%a") then
      --letter, but we can match to numbers afterwards
      char_type = "%w"
    elseif char:match("%d") then
      --number
      char_type = "%d"      
    end

    local pattern_length = 0

    if char_type == "" then
      --op
      while (not (text:sub(pos + pattern_length, pos + pattern_length):match("%s"))) 
        and (not (text:sub(pos + pattern_length, pos + pattern_length):match("%w"))) and pos + pattern_length <= length do
        --continue the token until a space or alphanumeric is encountered

        pattern_length = pattern_length + 1
      end
    else
      --id (or num)
      while (text:sub(pos + pattern_length, pos + pattern_length):match(char_type)) and pos + pattern_length <= length do
        --continue the token as long as the next character is what char is

        pattern_length = pattern_length + 1
      end
    end

    if char_type == "%s" then
      --dont insert space
    else
      local token_type = char_type == "" and "op" or "id"

      if char_type == "%d" then
        --token is a number if it started with one
        token_type = "num"
      end

      local token_value = text:sub(pos, pos + pattern_length - 1)
      tokens[#tokens + 1] = {type = token_type, value = token_value}
    end

    pos = pos + pattern_length
  end

  return tokens
end

function compiler.compile(path)
  -- soon tm
end

compiler.lexer = lexer

return compiler