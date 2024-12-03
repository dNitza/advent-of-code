class Puzzle
  PATTERN = /mul[(](\d{1,3}),(\d{1,3})[)]/i
  PATTERN_TWO = /mul[(](\d{1,3}),(\d{1,3})[)]|(don[']t)|(do)/i

  def part1(input)
    muls = input.first.scan(PATTERN)
    muls.map do |pair|
      Integer(pair[0]) * Integer(pair[1])
    end.sum
  end

  def part2(input)
    should_multiply = true
    isns = input.first.scan(PATTERN_TWO)

    isns
      .map(&:compact)
      .map do |vals|
        case vals.first
        when "don't"
          should_multiply = false
          nil
        when "do"
          should_multiply = true
          nil
        else
          if should_multiply
            Integer(vals[0]) * Integer(vals[1])
          else
            0
          end
        end
      end
      .compact
      .sum
  end
end
