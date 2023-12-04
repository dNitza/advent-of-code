class Puzzle

  def part1(input)
    input
      .map { |l|
        l.gsub(/Card \d+[:]\s/, "")
          .split("|")
          .map{|v| v.split(" ")}
      }
      .map { |c|
        c[0] & c[1]
      }
      .map { |c|
        next 0 if c.count <= 0
        1 * 2**(c.count-1)
      }
      .inject(:+)
  end

  def part2(input)
    @win_cache = {}
    @tally = 0
    cards = input
              .map { |l|
                l.gsub(/Card \d+[:]\s/, "")
                 .split("|")
                 .map{|v| v.split(" ")}
              }

    cards.each_with_index do |_, index|
      play(cards, index)
    end

    @tally
  end

  private

  def play(cards, index)
    @tally += 1
    # puts "round ##{index + 1} — #{wins(cards[index])}"

    cards
      .slice(index + 1, wins(index + 1, cards[index]))
      .each_with_index do |_, idx|
        play(cards, index + 1 + idx)
      end
  end

  def wins(card_id, card)
    @win_cache[card_id] ||= (card[0] & card[1]).count
  end
end
