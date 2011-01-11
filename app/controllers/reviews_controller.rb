class ReviewsController < ApplicationController
  def create
    Review.create(params[:review])
    render :text => "test"
  end
end
