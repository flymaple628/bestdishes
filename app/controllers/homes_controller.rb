class HomesController < ApplicationController
	def index

	end

	def about
		@users=User.count
		@dishes=Dish.count
		@comments=Comment.count
	end

	def profile
	 #params[:id]=2

		if User.where(:id=>params[:id])
			flash[:alert] = "user not exeist"
			redirect_to '/about'
		else
			@user=User.find(params[:id])
		end
		@dishes=Dish.where(user_id:params[:id])
		@comments=Comment.where(user_id:params[:id])
		#render :text=>@dishes.inspect
	end
end
