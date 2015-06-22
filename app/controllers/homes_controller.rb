class HomesController < ApplicationController
	def index

	end

	def about
		@users=User.count
		@dishes=Dish.count
		@comments=Comment.count
	end

	def profile
		params[:id]=2
		@user=User.find(params[:id])
		@dishes=Dish.where(user_id:params[:id])
		@comments=Comment.where(user_id:params[:id])
		#render :text=>@dishes.inspect
	end
end
