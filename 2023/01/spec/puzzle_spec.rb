require_relative "../lib/puzzle"

RSpec.describe Puzzle do
  
  subject { described_class.new }

  it "part 1" do
    input = <<-INPUT
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
    INPUT

    expect(subject.part1(input.split.map(&:chomp))).to eq 142
  end

  it "part 2" do
    input = <<-INPUT
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
      pxxtd793frjfckbhstcdhsrx58mksktwoneqx
    INPUT

    expect(subject.part2(input.split.map(&:chomp))).to eq 352
  end
end
