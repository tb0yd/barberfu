require 'spec_helper'

describe ReviewsController do
  def sample
    { :name => "Choice Cutts", :zip => 27701, :rating => 5 }
  end
  
  describe "#create" do
    it "should create a review" do
      lambda { post :create, :review => sample }.should change(Review, :count).by(1)
    end
    
    it "should save the review info" do
      post :create, :review => sample
      Review.last.name.should == "Choice Cutts"
      Review.last.zip.should == 27701
    end
  end
  
  describe "#index" do
    before(:each) do
      Review.create(sample)
    end
    
    it "should expose a review" do
      get :index
      assigns[:reviews].include?(Review.first).should be_true
    end
  end
end
