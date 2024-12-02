class Puzzle
  def part1(input)
    input.map do |line|
      dir = nil
      vals = line.split(" ").each_cons(2).map do |first, second|
        next_dir = if Integer(first) > Integer(second)
          :increase
        elsif Integer(first) < Integer(second)
          :decrease
        else
          :no_change
        end
        dir = next_dir if dir.nil?
        (Integer(first) - Integer(second)).abs > 3 || dir != next_dir
      end

      vals.all?(false) ? 1 : 0
    end.sum
  end

  def part2(input)
    input.count { |levels|
      levels = levels.split(" ")
      safe?(levels) || safe_by_removing_level?(levels)
    }
  end

  def safe?(report_result)
    res = report_result.each_cons(2).map do |first, second|
      if Integer(first) < Integer(second) && Integer(second) - Integer(first) <= 3
        :increase
      elsif Integer(first) > Integer(second) && Integer(first) - Integer(second) <= 3
        :decrease
      else
        :bad_step
      end
    end

    res.all? { |x| x == :increase } || res.all? { |x| x == :decrease }
  end

  def safe_by_removing_level?(report)
    0.upto(report.size).find do |i|
      sub = report.dup
      sub.delete_at(i)
      safe?(sub)
    end
  end
end
