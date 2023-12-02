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

describe("part2", function()
  it("works", function()
    local input = {
      "two1nine",
      "eightwothree",
      "abcone2threexyz",
      "xtwone3four",
      "4nineeightseven2",
      "zoneight234",
      "7pqrstsixteen",
    }

    local result = day1.part2(input)

    assert.are.equal(281, result)
  end)
end)

describe("advanced_parse", function()
  it("works", function()
    local inputs = {
      "two1nine",
      "eightwothree",
      "abcone2threexyz",
      "xtwone3four",
      "4nineeightseven2",
      "zoneight234",
      "7pqrstsixteen",
    }
    local expecteds = {
      29,
      83,
      13,
      24,
      42,
      14,
      76,
    }

    for k, v in ipairs(inputs) do
      local result = day1.advanced_parse(v)
      assert.are.equal(expecteds[k], result)
    end
  end)
end)
