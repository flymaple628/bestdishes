class Dish < ActiveRecord::Base
	belongs_to :restaurant
	has_many :comments
	has_many :dish_tagsships
	has_many :tags ,:through=>:dish_tagsships
	has_many :user_dishships
	has_many :users ,:through=>:user_dishships
end
