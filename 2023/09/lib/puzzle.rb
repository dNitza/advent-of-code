class Puzzle

  def part1(input)
    extrapolated_values = input.map do |line|
      nums = [line.split(" ").map(&:to_i)]

      while !nums.last.all?(&:zero?) do
        nums << next_in_series(nums)
      end

      nums.reverse.inject(0) do |sum, numbers|
        sum + numbers.last
      end
    end

    extrapolated_values.sum
  end

  def part2(input)
    extrapolated_values = input.map do |line|
      nums = [line.split(" ").map(&:to_i).reverse]

      while !nums.last.all?(&:zero?) do
        nums << next_in_series(nums)
      end

      nums.reverse.inject(0) do |sum, numbers|
        sum + numbers.last
      end
    end

    extrapolated_values.sum
  end

  private

  def next_in_series(numbers)
    numbers.last.map.with_index(1) do |n, i|
      next if i+1 > numbers.last.count

      numbers.last[i] - n
    end.compact
  end
end
