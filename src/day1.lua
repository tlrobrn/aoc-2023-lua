local M = {}

function M.part1(input)
  local sum = 0
  for _, line in ipairs(input) do
    sum = sum + M.parse(line)
  end

  return sum
end

function M.part2(input)
  local sum = 0
  for _, line in ipairs(input) do
    sum = sum + M.advanced_parse(line)
  end

  return sum
end

function M.parse(line)
  local digits = {}
  for digit in string.gmatch(line, "%d") do
    table.insert(digits, digit)
  end

  return digits[1] * 10 + digits[#digits]
end

local function FSM(t)
  local a = setmetatable({}, {
    __index = function()
      return setmetatable({}, {
        __index = function(_, e)
          return { new = e, digit = tonumber(e) }
        end,
      })
    end,
  })

  for _, v in ipairs(t) do
    local old, event, new, digit = v[1], v[2], v[3], v[4]

    if not rawget(a, old) then
      a[old] = setmetatable({}, {
        __index = function(_, e)
          return { new = e, digit = tonumber(e) }
        end,
      })
    end
    a[old][event] = { new = new, digit = digit }
  end

  return a
end

local fsm = FSM({
  { "o", "n", "on" },
  { "on", "e", "e", 1 },
  { "on", "i", "ni" },
  { "t", "w", "tw" },
  { "t", "h", "th" },
  { "tw", "o", "o", 2 },
  { "th", "r", "thr" },
  { "thr", "e", "thre" },
  { "thre", "e", "e", 3 },
  { "thre", "i", "ei" },
  { "f", "o", "fo" },
  { "f", "i", "fi" },
  { "fo", "u", "fou" },
  { "fo", "n", "on" },
  { "fou", "r", "", 4 },
  { "fi", "v", "fiv" },
  { "fiv", "e", "e", 5 },
  { "s", "i", "si" },
  { "s", "e", "se" },
  { "si", "x", "", 6 },
  { "se", "v", "sev" },
  { "se", "i", "ei" },
  { "sev", "e", "seve" },
  { "seve", "n", "n", 7 },
  { "seve", "i", "ei" },
  { "e", "i", "ei" },
  { "ei", "g", "eig" },
  { "eig", "h", "eigh" },
  { "eigh", "t", "t", 8 },
  { "n", "i", "ni" },
  { "ni", "n", "nin" },
  { "nin", "e", "e", 9 },
})

function M.advanced_parse(line)
  local digits = {}
  local state = { new = "" }
  for c in string.gmatch(line, ".") do
    state = fsm[state.new][c]
    if state.digit then
      table.insert(digits, state.digit)
    end
  end

  return digits[1] * 10 + digits[#digits]
end

return M
