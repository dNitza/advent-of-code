class Puzzle
  def part1(input)
    games = build_games(input)

    result = games.reject do |game|
      game[:rounds].any? { |round|
        round[:red] > 12 ||
          round[:green] > 13 ||
          round[:blue] > 14
      }
    end

    result.map{|r| r[:id]}.inject(:+)
  end

  def part2(input)
    games = build_games(input)

    games.map do |game|
      min_red = game[:rounds]
                  .map{|r| r[:red].zero? ? nil : r[:red] }
                  .compact
                  .max
      min_green = game[:rounds]
                    .map{|r| r[:green].zero? ? nil : r[:green] }
                    .compact
                    .max
      min_blue = game[:rounds]
                   .map{|r| r[:blue].zero? ? nil : r[:blue] }
                   .compact
                   .max

      [min_red, min_green, min_blue].inject(:*)
    end.inject(:+)
  end

  private

  def build_games(input)
    # game = {
    #   id: 0,
    #   rounds: [
    #     red: 0,
    #     green: 0,
    #     blue: 0,
    #   ]
    # }

    input.map do |line|
      id = line.scan(/(\d+)[:]/).flatten.first.to_i
      game = line.gsub("Game #{id}: ", "").split(";")
      rounds = game.map do |reveal|
        red = reveal.scan(/(\d+) red/).flatten.first&.to_i || 0
        green = reveal.scan(/(\d+) green/).flatten.first&.to_i || 0
        blue = reveal.scan(/(\d+) blue/).flatten.first&.to_i || 0

        {
          red: red,
          green: green,
          blue: blue
        }
      end

      {
        id: id,
        rounds: rounds
      }
    end
  end
end
