module StreamProcessing
  def call(stream)
    stream = remove_ignored_chars(stream)
    stream = remove_garbage(stream)
    calculate_score(stream.chars)
  end

  class << self
    private

    def remove_ignored_chars(stream)
      stream.gsub(/!./, '')
    end

    def remove_garbage(stream)
      stream.gsub(/<[^>]*>/, '').gsub(/,/, '')
    end

    def calculate_score(chars)
      total = 0
      depth = 0
      chars.each do |char|
        if char == '{'
          depth += 1
          total += depth
        else
          depth -= 1
        end
      end
      total
    end
  end

  module_function :call
end


puts StreamProcessing.call('{}') == 1
puts StreamProcessing.call('{{{}}}') == 6
puts StreamProcessing.call('{{},{}}') == 5
puts StreamProcessing.call('{{{},{},{{}}}}') == 16
puts StreamProcessing.call('{<a>,<a>,<a>,<a>}') == 1
puts StreamProcessing.call('{{<ab>},{<ab>},{<ab>},{<ab>}}') == 9
puts StreamProcessing.call('{{<!!>},{<!!>},{<!!>},{<!!>}}') == 9
puts StreamProcessing.call('{{<a!>},{<a!>},{<a!>},{<ab>}}') == 3
