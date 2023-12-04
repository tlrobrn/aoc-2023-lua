require("src.pp")
local M = {}

local function parsenumbers(line, y, t)
  local i = 1

  while true do
    local start, stop, number = line:find("(%d+)", i)

    number = tonumber(number)
    if not number then
      break
    end

    t[number] = t[number] or {}
    table.insert(t[number], {})
    for x = start, stop do
      table.insert(t[number][#t[number]], { x, y })
    end

    i = stop + 1
  end
end

local function parsesymbols(line, y, t)
  local i = 1
  while true do
    local start, _, symbol = line:find("([^%d%.])", i)
    if not start then
      break
    end
    t[start] = t[start] or {}
    t[start][y] = symbol
    i = start + 1
  end
end

local function parse(input)
  local partnos = {}
  local symbols = {}

  for row, line in ipairs(input) do
    parsenumbers(line, row, partnos)
    parsesymbols(line, row, symbols)
  end

  return partnos, setmetatable(symbols, {
    __index = function()
      return {}
    end,
  })
end

function M.part1(input)
  local partnos, symbols = parse(input)
  local sum = 0

  for number, appearances in pairs(partnos) do
    for _, coords in ipairs(appearances) do
      for _, coord in ipairs(coords) do
        local x, y = table.unpack(coord)

        if symbols[x - 1][y - 1] or symbols[x - 1][y] or symbols[x - 1][y + 1] then
          sum = sum + number
          goto continue
        end

        if symbols[x][y - 1] or symbols[x][y + 1] then
          sum = sum + number
          goto continue
        end

        if symbols[x + 1][y - 1] or symbols[x + 1][y] or symbols[x + 1][y + 1] then
          sum = sum + number
          goto continue
        end
      end
      ::continue::
    end
  end

  return sum
end

function M.part2(input)
  return ""
end

return M
