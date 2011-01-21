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

  context "yes typo with name match" do
    subject { Review.new(:name => "Choice Cuts", :name_match => "Choice Cutts") }
    it {should be_valid}
  end
  
  describe "#search" do
    subject { Review.search(@arg) }
    
    context "exact search" do
      before { @arg = "Choice Cutts" }
      it {should == ["Choice Cutts"]}
    end
    
    context "inexact search" do
      before { @arg = "Choice Cuts" }
      it {should == ["Choice Cutts"]}
    end
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
  
  describe "#good_matches" do
    subject { TypoCheck[@arg].good_matches }
    
    context "exact match" do
      before { @arg = "one" }
      it {should == ["one"]}
    end
    
    context "inexact match" do
      before { @arg = "on" }
      it {should == ["one"]}
    end
    
    context "no match" do
      before { @arg = "four" }
      it {should == []}
    end
  end
end