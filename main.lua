local function load_day(n)
  return require("src.day" .. n)
end

local function read_input()
  local input = {}
  for line in io.stdin:lines() do
    table.insert(input, line)
  end
  return input
end

local day = load_day(arg[1])
local input = read_input()

local result = day.part1(input)
print("Part 1: " .. result)
