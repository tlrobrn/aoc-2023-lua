local M = {}
M.__index = M

local function define(transisions, default)
  default = default or function(k)
    return { k }
  end

  local function indexfn(_, k)
    return default(k)
  end

  local definition = setmetatable({}, {
    __index = function()
      return setmetatable({}, {
        __index = indexfn,
      })
    end,
  })

  for _, transition in ipairs(transisions) do
    local state, event, next, result = table.unpack(transition)

    if not rawget(definition, state) then
      definition[state] = setmetatable({}, { __index = indexfn })
    end
    definition[state][event] = { next, result }
  end

  return definition
end

function M:new(transitions, default)
  local o = setmetatable({}, self)
  o.definition = define(transitions, default)
  o.state = ""
  return o
end

function M:event(e)
  local next, result = table.unpack(self.definition[self.state][e])
  self.state = next

  return result
end

function M:process(input)
  local results = {}
  for char in input:gmatch(".") do
    local result = self:event(char)
    if result then
      table.insert(results, result)
    end
  end

  return results
end

function M:reset()
  self.state = ""
end

return M
