require 'spec_helper'

describe Review do
  
end

describe TypoCheck do
  before { TypoCheck.dictionary = ["one", "two", "three"] }
  
  context "no typo" do
    subject { TypoCheck.new("one").result }
    it {should be_false}
  end
  
  context "yes typo" do
    subject { TypoCheck.new("eno").result }
    it {should be_true}
  end
end