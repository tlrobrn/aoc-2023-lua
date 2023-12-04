local M = {}

local function parse(line)
  local id = tonumber(line:match("%d+"))
  local results = { id = id }

  for count, color in line:gmatch("(%d+) (%w+)") do
    count = tonumber(count)
    local currentcount = results[color] or 0
    if count > currentcount then
      results[color] = count
    end
  end

  results.power = results.red * results.blue * results.green

  return results
end

function M.part1(input)
  local limits = {
    red = 12,
    green = 13,
    blue = 14,
  }

  local sum = 0

  for _, line in ipairs(input) do
    local result = parse(line)

    for color, max in pairs(limits) do
      if max < result[color] then
        goto continue
      end
    end
    sum = sum + result.id
    ::continue::
  end

  return sum
end

function M.part2(input)
  local sum = 0

  for _, line in ipairs(input) do
    local result = parse(line)

    sum = sum + result.power
  end

  return sum
end

return M
