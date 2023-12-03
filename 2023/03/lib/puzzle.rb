class Puzzle

  def part1(input)
    symbol_positions = {}
    input.each_with_index{ |l ,idx|
      symbol_positions[idx] = []
      l.enum_for(:scan, /[^a-zA-Z\d[.]:]/).each {
        symbol_positions[idx] << Regexp.last_match.begin(0)
      }
    }
    number_positions = input.flat_map.each_with_index{|l ,idx|  l.enum_for(:scan, /\d+/).map { [idx, [Regexp.last_match.offset(0), Regexp.last_match.to_s.to_i]] } }

    res = number_positions.map do |pos|
      line = pos[0]
      range = pos[1][0]
      num = pos[1][1]

      same_line = symbol_positions[line].any? { |pos| adjacent(range, pos) }
      above = line < (input.count - 1) && symbol_positions[line + 1].any? { |pos| adjacent(range, pos) }
      below = line > 0 && symbol_positions[line - 1].any? { |pos| adjacent(range, pos) }

      num if same_line || above || below
    end

    res.compact.inject(:+)
  end

  def part2(input)
    potential_gear_positions = {}
    number_positions = {}

    input.each_with_index { |l ,idx|
      potential_gear_positions[idx] = []
      number_positions[idx] = []

      l.enum_for(:scan, /[*]/).each {
        potential_gear_positions[idx] << Regexp.last_match.begin(0)
      }

      l.enum_for(:scan, /\d+/).each do
        number_positions[idx] << [Regexp.last_match.offset(0), Regexp.last_match.to_s.to_i]
      end
    }

    gears = potential_gear_positions.flat_map do |line, positions|
      positions.map do |gear|

        lines = [
          line < (input.count - 1) && number_positions[line + 1],
          line > 0 && number_positions[line - 1],
          number_positions[line]
        ].compact

        nums = lines
                 .flat_map { |l| l.select { |ll| adjacent(ll[0], gear) }.map(&:last) }
                 .flatten
                 .compact

        next 0 if nums.count != 2

        nums.inject(:*)
      end
    end

    gears.inject(:+)
  end

  private

  def adjacent(range, gear)
    (range[0] - 1...range[1] + 1).include? gear
  end
end
