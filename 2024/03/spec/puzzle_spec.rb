require_relative "../lib/puzzle"

RSpec.describe Puzzle do
  subject { described_class.new }

  it "part 1" do
    input = <<~INPUT
      xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    INPUT

    expect(subject.part1(input.split("\n").map(&:chomp))).to eq 161
  end

  it "part 2" do
    input = <<-INPUT
      xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
    INPUT

    expect(subject.part2(input.split("\n").map(&:chomp))).to eq 48
  end
end
