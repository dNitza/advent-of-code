class Puzzle
  ORDER = {"A" => "a", "K" => "b", "Q" => "c", "J" => "d", "T" => "e", "9" => "f", "8" => "g", "7" => "h", "6" => "i", "5" => "j", "4" => "k", "3" => "l", "2" => "m"}.freeze
  IMPROVED_ORDER = {"A" => "a", "K" => "b", "Q" => "c", "T" => "d", "9" => "e", "8" => "f", "7" => "g", "6" => "h", "5" => "i", "4" => "j", "3" => "k", "2" => "l", "J" => "m"}.freeze

  def part1(input)
    rounds = input.map { |l| l.split(" ") }
    sorted_rounds = rounds
                      .sort {|a,b| [hand_type(a[0]), hand_value(b[0])] <=> [hand_type(b[0]), hand_value(a[0])] }
    sorted_rounds
      .map
      .with_index(1) {|r, idx| r[1].to_i * idx }
      .sum
  end

  def part2(input)
    rounds = input
               .map { |l| l.split(" ") }
    sorted_rounds = rounds
                      .sort {|a,b| [improve_hand(a[0]), improved_hand_value(b[0])] <=> [improve_hand(b[0]), improved_hand_value(a[0])] }
    sorted_rounds
      .map
      .with_index(1) {|r, idx| r[1].to_i * idx }
      .sum
  end

  private

  def hand_value(hand)
    hand.gsub(/(.)\0*/).map{ |v| ORDER[v] }.join("")
  end

  def improved_hand_value(hand)
    hand.gsub(/(.)\0*/).map{ |v| IMPROVED_ORDER[v] }.join("")
  end

  def hand_type(hand)
    cards = hand.gsub(/(.)\0*/).to_a
    sorted_cards = cards.tally.values.sort {|a,b| b <=> a}
    score_hand(sorted_cards)
  end

  def improve_hand(hand)
    cards = hand.gsub(/(.)\0*/).to_a
    return hand_type(hand) unless cards.any? { |c| c == "J" }
    return hand_type(hand) if cards.all? { |c| c == "J" }

    card_types = cards.tally
    improve_by = card_types["J"]
    type_to_improve = type_to_improve(card_types)
    card_types[type_to_improve] += improve_by if improve_by && type_to_improve
    card_types.delete("J")
    sorted_cards = card_types.values.sort {|a,b| b <=> a}

    score_hand(sorted_cards)
  end

  def type_to_improve(cards)
    return nil if cards.empty?
    no_jack = cards.reject{|k,v| k == "J" }
    return nil if no_jack.empty?
    no_jack.max_by{|_,v| v}[0]
  end

  def score_hand(cards)
    return 6 if cards == [5]
    return 5 if cards.any? { |k| k == 4}
    return 4 if cards == [3,2]
    return 3 if cards == [3,1,1]
    return 2 if cards == [2,2,1]
    return 1 if cards == [2,1,1,1]
    return 0 if cards == [1,1,1,1,1]
  end
end
