local day1 = require("day1")

describe("part1", function()
  it("works", function()
    local input = {
      "1abc2",
      "pqr3stu8vwx",
      "a1b2c3d4e5f",
      "treb7uchet",
    }
    local result = day1.part1(input)
    assert.are.equal(142, result)
  end)
end)

describe("parse", function()
  it("returns the numerical value", function()
    local result = day1.parse("1abc2")
    assert.are.equal(12, result)
  end)

  it("works with more than two digits", function()
    local result = day1.parse("elkj1a89g43")
    assert.are.equal(13, result)
  end)
end)