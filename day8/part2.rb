module RegistryInstructions
  def call(path_to_file)
    instructions = File.readlines(path_to_file).map do |line|
      regexp = /^(?<reg>\w+) (?<inst>\w+) (?<adj>[-\d]+) if (?<cond>.+)$/
      regexp.match(line.chomp).named_captures
    end

    registry = binding

    instructions.each do |inst|
      registry.local_variable_set(inst['reg'], 0)
    end

    instructions.map do |inst|
      operator = case inst['inst']
                 when 'inc'
                   '+'
                 when 'dec'
                   '-'
                 end
      command = "#{inst['reg']} = #{inst['reg']} #{operator} #{inst['adj']} if #{inst['cond']}"
      eval command, registry
    end.compact.max
  end

  module_function :call
end

puts RegistryInstructions.call('example_input')
