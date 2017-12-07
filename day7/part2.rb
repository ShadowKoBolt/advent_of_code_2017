module TreeRootFinder
  def call(path_to_input)
    File.readlines(path_to_input).map do |line|
      Node.new(line).register!
    end
    check_self_and_children_for_unbalanced_nodes(Node.root).flatten.compact.last
  end

  class << self
    private

    def check_self_and_children_for_unbalanced_nodes(node)
      [node.unbalanced_child_adjustment] +
        node.children.map do |child|
          check_self_and_children_for_unbalanced_nodes(child)
        end
    end
  end

  class Node
    attr_reader :name, :weight, :child_names

    @@store = []

    class << self
      def find(name)
        all.find { |node| node.name == name }
      end

      def all
        @@store
      end

      def root
        children_of_anything = all.map(&:child_names).flatten
        all.find { |node| !children_of_anything.include?(node.name) }
      end
    end

    def initialize(string)
      match_data = /^(?<name>\w+) \((?<weight>\d+)\)( -> (?<child_names>.+$))?/.match(string.chomp)
      @name = match_data[:name]
      @weight = match_data[:weight].to_i
      @child_names = match_data[:child_names]&.split(', ') || []
    end

    def register!
      @@store << self
    end

    def calculated_weight
      @weight + children.map(&:calculated_weight).sum
    end

    def children_are_right_weight?
      [0,1].include?(children.map(&:calculated_weight).uniq.length)
    end

    def unbalanced_child_adjustment
      return nil if children_are_right_weight?
      grouped_weights = children.group_by { |node| node.calculated_weight }
      goal_weight = grouped_weights.find { |k,v| v.size > 1 }.first
      problem_group = grouped_weights.find { |k,v| v.size == 1 }
      incorrect_weight = problem_group.first
      incorrect_node = problem_group.last.last
      difference = goal_weight - incorrect_weight
      incorrect_node.weight + difference
    end

    def children
      @child_names.map { |name| Node.find(name) }
    end
  end

  module_function :call
end
