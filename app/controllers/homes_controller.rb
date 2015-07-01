class HomesController < ApplicationController

	def index

	end

	def about
		@users=User.count
		@dishes=Dish.count
		@comments=Comment.count
	end

end
