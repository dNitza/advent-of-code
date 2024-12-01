class Puzzle
  def part1(input)
    list = {left: [], right: []}
    input
      .map { |line| line.split(" ") }
      .each_with_object(list) { |item, memo|
        memo[:left] << Integer(item[0])
        memo[:right] << Integer(item[1])
      }
    sorted_left = list[:left].sort
    sorted_right = list[:right].sort

    sorted_left.each_with_index.map do |left, idx|
      [left, sorted_right[idx]].sort.reverse.inject(:-)
    end.inject(:+)
  end

  def part2(input)
    list = {left: [], right: []}
    input
      .map { |line| line.split(" ") }
      .each_with_object(list) { |item, memo|
        memo[:left] << Integer(item[0])
        memo[:right] << Integer(item[1])
      }

    right_frequency = list[:right].tally

    list[:left].map do |left|
      (right_frequency[left] || 0) * left
    end.inject(:+)
  end
end
