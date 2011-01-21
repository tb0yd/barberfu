require 'spec_helper'

describe Review do

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