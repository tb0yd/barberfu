require 'spec_helper'

describe ReviewsController do
  describe "#create" do
    it "should save the review" do
      lambda {
        post :create, :review => { :name => "Choice Cutts", :zip => 27701, :rating => 5 }
      }.should change(Review, :count).by(1)
      Review.last.name.should == "Choice Cutts"
      Review.last.zip.should == 27701
    end
  end
end
