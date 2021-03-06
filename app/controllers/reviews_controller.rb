class ReviewsController < ApplicationController

  # if current_user.has_reviewed? @restaurant
  #   # some error handling goes here!
  # end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant.reviews.create(review_params, )
  

    if @restaurant.reviews.first.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
       redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
     else
       render :new
     end
   end
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
