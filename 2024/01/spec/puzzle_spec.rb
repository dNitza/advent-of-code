require_relative "../lib/puzzle"

RSpec.describe Puzzle do
  subject { described_class.new }

  it "part 1" do
    input = <<~INPUT
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3
    INPUT

    expect(subject.part1(input.split("\n").map(&:chomp))).to eq 11
  end

  it "part 2" do
    input = <<-INPUT
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    INPUT

    expect(subject.part2(input.split("\n").map(&:chomp))).to eq 31
  end
end
