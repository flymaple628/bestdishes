class ProfilesController < ApplicationController

	before_action :authenticate_user!, :except => [:show]

	def show

		@user = User.find(params[:id])

		@dishes = @user.dishes
		@comments = @user.comments
	end

	def update
		@user = current_user
		@user.update(user_params)

		redirect_to profile_path(@user)
	end
	#GET /profile/:id/like_list
	def like_list
		@dishes=current_user.likes(params[:id])
	end

	#GET /profile/:id/faverite_list
	def faverite_list
			@dishes = current_user.faverites(params[:id])
	end

	#GET /profile/user_list
	def user_list
		@users=User.all.where.not(:id=>current_user)
	end
	protected

	def user_params
		params.require(:user).permit(:description)
	end

end
