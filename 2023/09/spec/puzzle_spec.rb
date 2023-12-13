require_relative "../lib/puzzle"

RSpec.describe Puzzle do
  
  subject { described_class.new }

  it "part 1" do
    input = <<-INPUT
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
    INPUT

    expect(subject.part1(input.split("\n").map(&:chomp))).to eq 114
  end

  it "part 2" do
    input = <<-INPUT
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
    INPUT

    expect(subject.part2(input.split("\n").map(&:chomp))).to eq 2
  end
end
