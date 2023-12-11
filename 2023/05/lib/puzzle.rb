require "parallel"

class Puzzle
  def part1(input)
    # seeds: 79 14 55 13
    #
    # seed-to-soil map:
    # 50 98 2
    # 52 50 48
    #
    # soil-to-fertilizer map:
    # 0 15 37
    # 37 52 2
    # 39 0 15
    #
    # fertilizer-to-water map:
    # 49 53 8
    # 0 11 42
    # 42 0 7
    # 57 7 4
    #
    # water-to-light map:
    # 88 18 7
    # 18 25 70
    #
    # light-to-temperature map:
    # 45 77 23
    # 81 45 19
    # 68 64 13
    #
    # temperature-to-humidity map:
    # 0 69 1
    # 1 0 69
    #
    # humidity-to-location map:
    # 60 56 37
    # 56 93 4

    seeds = input
              .first
              .gsub("seeds: ", "")
              .split(" ")
              .map(&:to_i)

    seeds_to_soil = get_map(input: input, name: "seed-to-soil map:")
    soil_to_fert = get_map(input: input, name: "soil-to-fertilizer map:")
    fert_to_water = get_map(input: input, name: "fertilizer-to-water map:")
    water_to_light = get_map(input: input, name: "water-to-light map:")
    light_to_temp = get_map(input: input, name: "light-to-temperature map:")
    temp_to_humidity = get_map(input: input, name: "temperature-to-humidity map:")
    humidity_to_location = get_map(input: input, name: "humidity-to-location map:")

    closest_seed = seeds.map do |seed|
      sts = resolve_map(val: seed, target: seeds_to_soil)
      stf = resolve_map(val: sts, target: soil_to_fert)
      ftw = resolve_map(val: stf, target: fert_to_water)
      wtl = resolve_map(val: ftw, target: water_to_light)
      wtl = resolve_map(val: wtl, target: light_to_temp)
      ltt = resolve_map(val: wtl, target: temp_to_humidity)
      resolve_map(val: ltt, target: humidity_to_location)
    end.min

    closest_seed
  end

  def part2(input)
    @resolve_cache = {
      "seed" => {},
      "sts" => {},
      "stf" => {},
      "ftw" => {},
      "wtl" => {},
      "ltt" => {},
      "tth" => {},
    }

    seeds = input
              .first
              .gsub("seeds: ", "")
              .split(" ")
              .map(&:to_i)
              .each_slice(2)

    seed_ranges = seeds
                    .map {|s| (s[0]...s[0] + s[1]) }
                    .flatten
                    .sort_by(&:begin).inject([]) do |ranges, range|
                      if !ranges.empty? && ranges_overlap?(ranges.last, range)
                        ranges[0...-1] + [merge_ranges(ranges.last, range)]
                      else
                        ranges + [range]
                      end
                    end

    seeds_to_soil = get_map(input: input, name: "seed-to-soil map:")
    soil_to_fert = get_map(input: input, name: "soil-to-fertilizer map:")
    fert_to_water = get_map(input: input, name: "fertilizer-to-water map:")
    water_to_light = get_map(input: input, name: "water-to-light map:")
    light_to_temp = get_map(input: input, name: "light-to-temperature map:")
    temp_to_humidity = get_map(input: input, name: "temperature-to-humidity map:")
    humidity_to_location = get_map(input: input, name: "humidity-to-location map:")

    # puts humidity_to_location.map{|l| (l[0][0]...l[0][1])}.inspect

    humidity_to_location.map{|l| (l[0][0]...l[0][1])}.map do |range|
      range.map do |humloc|
        puts "#{(humloc / range.max.to_i) * 100.0}"
        loc = rev_resolve_map(val: humloc, target: humidity_to_location, type: "tth")
        tth = rev_resolve_map(val: loc, target: temp_to_humidity, type: "ltt")
        ltt = rev_resolve_map(val: tth, target: light_to_temp, type: "wtl")
        wtl = rev_resolve_map(val: ltt, target: water_to_light, type: "ftw")
        ftw = rev_resolve_map(val: wtl, target: fert_to_water, type: "stf")
        stf = rev_resolve_map(val: ftw, target: soil_to_fert, type: "sts")
        rev_resolve_map(val: stf, target: seeds_to_soil, type: "seed")
      end.min
    end.min * 2
    #
    # closest_seed.min
  end

  private

  def get_map(input: ,name:)
    seeds_to_soil_index = input
                            .find_index(name)

    maps = input[seeds_to_soil_index+1..-1]
                      .take_while {|v| v != ""}

    maps.map do |map|
      map.split(" ").map(&:to_i)
    end.map do |map|
      [[map[0], map[0]+map[2]], [map[1], map[1]+map[2]]]
    end
  end

  def cached_resolve(val:, target:, type:)
    @resolve_cache[type][val] ||= resolve_map(val: val, target: target)
  end

  def resolve_map(val:, target:, type: nil)
    # puts "resolving for #{val}"
    match = target.detect { |t|
      val >= t[1].first && val <= t[1].last
    }
    # if match
    #   puts "    match: #{match[0].first} + #{val} + #{match[1].first}"
    # else
    #   puts "    no match — #{val}"
    # end

    match.nil? ? val : match[0].first + (val - match[1].first)
  end

  def rev_resolve_map(val:, target:, type: nil)
    # puts "resolving for #{val}"
    match = target.detect { |t|
      val >= t[0].first && val <= t[0].last
    }
    # if match
    #   puts "    match: #{match[0].first} + #{val} + #{match[1].first}"
    # else
    #   puts "    no match — #{val}"
    # end

    match.nil? ? val : match[1].first + (val - match[0].first)
  end

  def ranges_overlap?(a, b)
    a.include?(b.begin) || b.include?(a.begin)
  end

  def merge_ranges(a, b)
    [a.begin, b.begin].min..[a.end, b.end].max
  end
end
