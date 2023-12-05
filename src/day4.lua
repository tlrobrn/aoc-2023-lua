require("src.stringutils")

local M = {}

local function parse(line)
  local _, i = string.find(line, ": ", 1, true)
  local winners_part, numbers_part = table.unpack(string.split(line, " | ", i + 1, true))

  local winners = {}
  for n in string.gmatch(winners_part, "(%d+)") do
    table.insert(winners, tonumber(n))
  end

  local numbers = {}
  for n in string.gmatch(numbers_part, "(%d+)") do
    table.insert(numbers, tonumber(n))
  end

  return winners, numbers
end

local function count(winners, numbers)
  local matches = 0

  local check = {}
  for _, w in ipairs(winners) do
    check[w] = true
  end

  for _, n in ipairs(numbers) do
    if check[n] then
      matches = matches + 1
    end
  end

  return matches
end

function M.part1(input)
  local sum = 0

  for _, line in ipairs(input) do
    local winners, numbers = parse(line)
    local matches = count(winners, numbers)

    if matches > 0 then
      sum = sum + 2 ^ (matches - 1)
    end
  end

  return math.floor(sum)
end

function M.part2(input)
  return #input
end

return M
