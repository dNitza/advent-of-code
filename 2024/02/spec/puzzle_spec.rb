require_relative "../lib/puzzle"

RSpec.describe Puzzle do
  subject { described_class.new }

  it "part 1" do
    input = <<~INPUT
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
    INPUT

    expect(subject.part1(input.split("\n").map(&:chomp))).to eq 2
  end

  it "part 2" do
    input = <<~INPUT
      7 6 4 2 1
      1 2 7 8 9
      9 7 6 2 1
      1 3 2 4 5
      8 6 4 4 1
      1 3 6 7 9
      32 34 31 30 29 28 25 23
      71 72 73 76 79 76
    INPUT

    expect(subject.part2(input.split("\n").map(&:chomp))).to eq 6
  end
end
