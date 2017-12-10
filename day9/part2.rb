module GarbageCounter
  def call(stream)
    stream = remove_ignored_chars(stream)
    count_removed_garbage(stream)
  end

  class << self
    private

    def remove_ignored_chars(stream)
      stream.gsub(/!./, '')
    end

    def count_removed_garbage(stream)
      stream.scan(/<([^>]*)>/).flatten.map(&:length).sum
    end
  end

  module_function :call
end

puts GarbageCounter.call('<>') == 0
puts GarbageCounter.call('<random characters>') == 17
puts GarbageCounter.call('<<<<>') == 3
puts GarbageCounter.call('<{!>}>') == 2
puts GarbageCounter.call('<!!>') == 0
puts GarbageCounter.call('<!!!>>') == 0
puts GarbageCounter.call('<{o"i!a,<{i<a>') == 10
