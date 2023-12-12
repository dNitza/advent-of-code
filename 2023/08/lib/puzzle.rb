require "parallel"

class Puzzle
  def part1(input)
    @nodes = {}

    current_node = "AAA"
    hops = 0

    directions = input[0]

    text_nodes = input.slice(2..-1)

    build_graph(text_nodes)

    while current_node != "ZZZ" do
      directions.chars.each do |direction|
        current_node = direction == "L" ? neighbors(current_node)[0] : neighbors(current_node)[1]
        hops += 1
      end
    end

    hops
  end

  def part2(input)
    @nodes = {}

    directions = input[0]
    text_nodes = input.slice(2..-1)
    build_graph(text_nodes)

    start_nodes = @nodes.keys.select {|n| n.end_with? "A"}

    total_hops = start_nodes.map do |node|
      hops = 0

      while !node.end_with?("Z") do
        directions.chars.each do |direction|
          node = direction == "L" ? neighbors(node)[0] : neighbors(node)[1]
          hops += 1
        end
      end

      hops
    end

    total_hops.inject do |sum, number|
      sum * number / sum.gcd(number)
    end
  end

  private

  def build_graph(nodes)
    nodes.each do |text_node|
      node, left, right = text_node.scan(/(\w{3})/).flatten

      insert_node(node)
      add_edge(node, left)
      add_edge(node, right)
    end
  end

  def insert_node(node)
    @nodes[node] = []
  end

  def add_edge(node1, node2)
    @nodes[node1] << node2
  end

  def neighbors(node)
    @nodes[node]
  end
end
