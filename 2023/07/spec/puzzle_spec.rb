require_relative "../lib/puzzle"

RSpec.describe Puzzle do
  
  subject { described_class.new }

  it "part 1" do
    input = <<-INPUT
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
    INPUT

    expect(subject.part1(input.split("\n").map(&:chomp))).to eq 6440
  end

  it "part 2" do
    input = <<-INPUT
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
    INPUT

    expect(subject.part2(input.split("\n").map(&:chomp))).to eq 5905
  end
end
