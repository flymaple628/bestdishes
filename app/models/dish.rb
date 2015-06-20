class Dish < ActiveRecord::Base
	belongs_to :restaurant
	has_many :comments
	has_many :dish_tagsships
	has_many :tags ,:through=>:dish_tagsships
end
