class ReviewsController < ApplicationController
  def create
    Review.create(params[:review])
    redirect_to :index
  end
  
  def index
    @reviews = Review.all
  end
  
  def new
    @review = Review.new
  end
  
  def search
    @reviews = Review.search(params[:name])
    render :template => "reviews/index"
  end
end
