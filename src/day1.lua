local FSM = require("src.fsm")
local M = {}

local function defaultparse(char)
  return { char, tonumber(char) }
end

local function process(input, fsm)
  local sum = 0

  for _, line in ipairs(input) do
    fsm:reset()

    local digits = fsm:process(line)
    local n = digits[1] * 10 + digits[#digits]

    sum = sum + n
  end

  return sum
end

M.simpleparser = FSM:new({}, defaultparse)

function M.part1(input)
  return process(input, M.simpleparser)
end

M.advancedparser = FSM:new({
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
}, defaultparse)

function M.part2(input)
  return process(input, M.advancedparser)
end

return M
