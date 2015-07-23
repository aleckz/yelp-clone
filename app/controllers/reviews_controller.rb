class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.has_reviewed? @restaurant
      flash[:notice] = "You've already reviewed this restaurant!"
      redirect_to restaurants_path
    else
    @restaurant.reviews.create(review_params)
    redirect_to restaurants_path
    end
  end

  def review_params
    params[:review][:user_id] = current_user.id
    params.require(:review).permit(:thoughts, :rating, :user_id)
  end
end
