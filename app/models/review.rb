require 'text'

class Review < ActiveRecord::Base
  validate :typo_check
  def typo_check
    TypoCheck.dictionary = Review.all.collect(&:name)
    if TypoCheck[self.name].result
      @errors.add(:name, "typo detected") unless self.name_match
    end
  end
  
  def self.search(name)
    TypoCheck.dictionary = Review.all.collect(&:name)
    TypoCheck[name].good_matches
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
  
  def good_matches
    @@dictionary.select { |item| Text::Levenshtein.distance(@word, item) < 2 }
  end
end