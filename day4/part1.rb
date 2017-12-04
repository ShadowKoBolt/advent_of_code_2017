module PassphraseCounter
  extend self

  def call(passphrases)
    passphrases.select do |passphrase|
      passphrase_valid?(passphrase.chomp)
    end.count
  end

  module_function :call

  def passphrase_valid?(passphrase)
    passphrase.split(' ').each do |word_being_checked|
      return false if passphrase.split(' ').select do |word|
        word == word_being_checked
      end.count > 1
    end
    true
  end
end
