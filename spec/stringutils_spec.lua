require("src.stringutils")

describe("string.gfind", function()
  it("returns sequence of all start and stop indices of a pattern", function()
    local s = "ab,c,def,"
    local result = string.gfind(s, ",")
    assert.are.same({ { 3, 3 }, { 5, 5 }, { 9, 9 } }, result)
  end)
end)

describe("string.split", function()
  it("returns the parts of the split string", function()
    local s = "ab,c,def,"
    local result = string.split(s, ",")
    assert.are.same({ "ab", "c", "def", "" }, result)
  end)
end)
