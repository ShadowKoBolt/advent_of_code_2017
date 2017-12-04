module PassphraseCounter
  extend self

  def call(passphrases)
    passphrases.select do |passphrase|
      passphrase_valid?(passphrase.chomp)
    end.count
  end

  module_function :call

  def passphrase_valid?(passphrase)
    return false if contains_any_anagrams?(passphrase.split(' '))
    true
  end

  def contains_any_anagrams?(words)
    !unique_words?(words.map { |word| word.chars.sort.join })
  end

  def unique_words?(words)
    words.each do |word_being_checked|
      return false if words.select do |word|
        word == word_being_checked
      end.count > 1
    end
    true
  end
end
