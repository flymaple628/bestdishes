class Tag < ActiveRecord::Base
	has_many :dish_tagsships
	has_many :dishes ,:through=>:dish_tagsships
end
