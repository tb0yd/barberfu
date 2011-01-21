class Review < ActiveRecord::Base
  def typo_check
    
  end
end

class TypoCheck
  attr_accessor :word
  cattr_accessor :dictionary
  
  def initialize(word)
    @word = word
  end
  def result
    !@@dictionary.include?(@word)
  end
end