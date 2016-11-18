class AddReviewsToRestaurants < ActiveRecord::Migration
  def change
    add_reference :restaurants, :review, index: true, foreign_key: true
  end
end
