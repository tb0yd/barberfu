require 'spec_helper'

describe Review do
  before {
    Review.create(:name => "Choice Cutts")
    Review.create(:name => "Great Clips")
    Review.create(:name => "2nd II None")
  }

  context "no typo" do
    subject { Review.new(:name => "Choice Cutts") }
    it {should be_valid}
  end

  context "yes typo" do
    subject { Review.new(:name => "Choice Cuts") }
    it {should_not be_valid}
  end
end

describe TypoCheck do
  before { TypoCheck.dictionary = ["one", "two", "three"] }
  context "no typo" do
    subject { TypoCheck["one"].result }
    it {should be_nil}
  end

  context "yes typo" do
    subject { TypoCheck["too"].result }
    it {should == "two"}
  end

  context "new word" do
    subject { TypoCheck["four"].result }
    it {should == nil}
  end
end