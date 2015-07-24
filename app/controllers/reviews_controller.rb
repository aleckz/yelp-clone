class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build(review_params)
    if @review.save
      redirect_to restaurants_path
    else
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])
      if user_did_not_create_review
        flash[:notice] = "You can't delete someone else's review"
        redirect_to restaurants_path
      else
        @review.destroy
        flash[:notice] = "Review successfully deleted"
        redirect_to restaurants_path
      end
    # @restaurant = Restaurant.find(params[:restaurant_id])

    # reviews = @restaurant.reviews.all
    # byebug
    # user_review = reviews.find(params[:id])

    # user_review.destroy
  end

  def review_params
    params[:review][:user] = current_user
    params.require(:review).permit(:thoughts, :rating, :user)
  end

  def user_did_not_create_review
    @review.user != current_user
  end
end
