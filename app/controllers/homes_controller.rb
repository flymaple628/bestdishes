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

			redirect_to '/about'
		end
		@dishes=Dish.where(user_id:params[:id])
		@comments=Comment.where(user_id:params[:id])
		#ender :html=>@user.inspect
		#render :html=>User.find_by_id(params[:id]).inspect
	end

	def profile_edit
		@user=User.find(params[:id])
		@user.update(user_params)
		redirect_to "/profile/#{params[:id]}"
	end

	def user_params
		params.require(:user).permit(:description)
	end
end
