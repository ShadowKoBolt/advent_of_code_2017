module TreeRootFinder
  def call(path_to_input)
    nodes = File.readlines(path_to_input).map do |line|
      Node.new(line)
    end

    children_of_anything = nodes.map(&:children).flatten

    nodes.find { |node| !children_of_anything.include?(node.name) }&.name || nil
  end

  class Node
    attr_reader :name, :children

    def initialize(string)
      match_data = /^(?<name>\w+) \((?<weight>\d+)\)( -> (?<children>.+$))?/.match(string.chomp)
      @name = match_data[:name]
      @weight = match_data[:weight]
      @children = match_data[:children]&.split(', ') || []
    end
  end

  module_function :call
end

raise StandardError unless TreeRootFinder.call('part1_example_input') == 'tknk'

puts TreeRootFinder.call('input')
