class Puzzle

  NUMBERS = {one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9}.freeze

  def part1(input)
    input.map{|line|
      matches = line.scan(/\d/) 
      Integer("#{matches[0]}#{matches[-1]}") 
    }.inject(:+)
  end

  def part2(input)
    num_pattern = NUMBERS.keys.join("|")

    input.map {|line|
      matches = line.scan(/(?=(#{num_pattern}|\d))/).first
      first = NUMBERS[matches[0].to_sym] || matches[0]
      last = NUMBERS[matches[-1].to_sym] || matches[-1]
      
      Integer("#{first}#{last}")
    }.inject(:+)
  end 
end
