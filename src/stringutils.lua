function string.gfind(s, pattern, init, plain)
  local indices = {}
  while true do
    local start, stop = string.find(s, pattern, init, plain)
    if not start then
      break
    end

    table.insert(indices, { start, stop })

    init = stop + 1
  end
  return indices
end

function string.split(s, pattern, init, plain)
  local parts = {}

  local indices = string.gfind(s, pattern, init, plain)
  table.insert(indices, 1, { 0, (init or 1) - 1 })
  for i, index in ipairs(indices) do
    local _, prev = table.unpack(index)
    local next, _ = table.unpack(indices[i + 1] or { 0 })
    table.insert(parts, string.sub(s, prev + 1, next - 1))
  end

  return parts
end
