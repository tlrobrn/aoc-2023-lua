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

describe("simpleparser", function()
  before_each(function()
    day1.simpleparser:reset()
  end)

  it("returns the numerical values", function()
    local result = day1.simpleparser:process("1abc2")
    assert.are.same({ 1, 2 }, result)
  end)

  it("works with more than two digits", function()
    local result = day1.simpleparser:process("elkj1a89g43")
    assert.are.same({ 1, 8, 9, 4, 3 }, result)
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

describe("advancedparser", function()
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
      { 2, 1, 9 },
      { 8, 2, 3 },
      { 1, 2, 3 },
      { 2, 1, 3, 4 },
      { 4, 9, 8, 7, 2 },
      { 1, 8, 2, 3, 4 },
      { 7, 6 },
    }

    for k, v in ipairs(inputs) do
      day1.advancedparser:reset()
      local result = day1.advancedparser:process(v)
      assert.are.same(expecteds[k], result)
    end
  end)
end)
