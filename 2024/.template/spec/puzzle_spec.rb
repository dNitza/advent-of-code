require_relative "../lib/puzzle"

RSpec.describe Puzzle do
  
  subject { described_class.new }

  it "part 1" do
    input = <<-INPUT
    INPUT

    expect(subject.part1(input.split("\n").map(&:chomp))).to eq true
  end

  it "part 2" do
    input = <<-INPUT
    INPUT

    expect(subject.part2(input.split("\n").map(&:chomp))).to eq true
  end
end
