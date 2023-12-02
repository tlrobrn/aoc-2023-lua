local M = {}

function M.part1(input)
  local sum = 0
  for _, line in ipairs(input) do
    sum = sum + M.parse(line)
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

return M
