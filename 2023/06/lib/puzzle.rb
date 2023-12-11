class Puzzle

  def part1(input)
    races = input.map { |l| l.scan(/\d+/).map(&:to_i) }
    races = races[0].zip(races[1])

    wins = {}
    races.each_with_object(wins) do |race, memo|
      (0...(race[0]).round).each do |time_held|
        wins[race[1]] ||= 0
        memo[race[1]] +=1 if time_held * (race[0] - time_held) > race[1]
      end
    end

    wins.values.inject(:*)
  end

  def part2(input)
    race = input.map { |l| l.scan(/\d+/).inject(:+) }.map(&:to_i)

    (0...(race[0])).map do |time_held|
      if time_held * (race[0] - time_held) > race[1]
        1
      else
        0
      end
    end.inject(:+)
  end 
end
