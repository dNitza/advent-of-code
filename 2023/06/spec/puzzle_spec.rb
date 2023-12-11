require_relative "../lib/puzzle"

RSpec.describe Puzzle do
  
  subject { described_class.new }

  it "part 1" do
    input = <<-INPUT
Time:      7  15   30
Distance:  9  40  200
    INPUT

    expect(subject.part1(input.split("\n").map(&:chomp))).to eq 288
  end

  it "part 2" do
    input = <<-INPUT
Time:      7  15   30
Distance:  9  40  200
    INPUT

    expect(subject.part2(input.split("\n").map(&:chomp))).to eq 71503
  end
end
