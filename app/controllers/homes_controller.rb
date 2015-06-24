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

		if User.exists?(:id=>params[:id])
			@user=User.find(params[:id])
		else
			flash[:alert] = "user not exeist"
			#render :html=>User.find_by_id(params[:id])
			redirect_to '/about'
		end
		@dishes=Dish.where(user_id:params[:id])
		@comments=Comment.where(user_id:params[:id])
		#render :text=>@dishes.inspect
	end
end
