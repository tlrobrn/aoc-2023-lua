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

local function neighbors(partno)
  local ns = {}

  for _, coord in ipairs(partno) do
    local x, y = table.unpack(coord)

    table.insert(ns, { x - 1, y - 1 })
    table.insert(ns, { x - 1, y })
    table.insert(ns, { x - 1, y + 1 })
    table.insert(ns, { x, y - 1 })
    table.insert(ns, { x, y + 1 })
    table.insert(ns, { x + 1, y - 1 })
    table.insert(ns, { x + 1, y })
    table.insert(ns, { x + 1, y + 1 })
  end

  return ns
end

function M.part1(input)
  local partnos, symbols = parse(input)
  local sum = 0

  for number, appearances in pairs(partnos) do
    for _, coords in ipairs(appearances) do
      for _, neighbor in ipairs(neighbors(coords)) do
        local x, y = table.unpack(neighbor)

        if symbols[x][y] then
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
  local function hash(coord)
    local x, y = table.unpack(coord)
    local l = #input[1]

    return ((y - 1) * l) + (x - 1)
  end

  local gears = {}
  local partnos, symbols = parse(input)

  for number, appearances in pairs(partnos) do
    for _, coords in ipairs(appearances) do
      for _, neighbor in ipairs(neighbors(coords)) do
        local x, y = table.unpack(neighbor)

        if symbols[x][y] == "*" then
          local i = hash({ x, y })
          gears[i] = gears[i] or {}
          table.insert(gears[i], number)
          goto continue
        end
      end
      ::continue::
    end
  end

  local sum = 0

  for _, gear in pairs(gears) do
    if #gear == 2 then
      sum = sum + (gear[1] * gear[2])
    end
  end

  return sum
end

return M
