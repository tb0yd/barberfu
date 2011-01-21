require 'text'

class Review < ActiveRecord::Base
  def typo_check

  end
end

class TypoCheck
  attr_accessor :word
  cattr_accessor :dictionary
  def self.[](*args); TypoCheck.new(*args) end

  def initialize(word)
    @word = word
  end

  def result
    if @@dictionary.include?(@word)
      nil
    else
      best_match
    end
  end

  def best_match
    matches = @@dictionary.select { |item| Text::Levenshtein.distance(@word, item) == 1 }
    matches[0]
  end
end