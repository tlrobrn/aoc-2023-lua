local day3 = require("day3")

describe("part1", function()
  it("works", function()
    local input = {
      "467..114..",
      "...*......",
      "..35...633", -- modified to have number at end of row
      "......#...",
      "617*......",
      ".....+.58.",
      "..592.592.", -- modified to have same number multiple times in a row
      "......755.",
      "...$.*....",
      ".617.598..", -- tweaked from example to capture the same number multiple times
    }
    local result = day3.part1(input)
    assert.are.equal(4906, result)
  end)
end)

describe("part2", function()
  it("works", function()
    local input = {
      "467..114..",
      "...*......",
      "..35..633.",
      "......#...",
      "617*......",
      ".....+.58.",
      "..592.....",
      "......755.",
      "...$.*....",
      ".664.598..",
    }
    local result = day3.part2(input)
    assert.are.equal(467835, result)
  end)
end)
