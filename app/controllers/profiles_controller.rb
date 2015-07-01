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

	protected

	def user_params
		params.require(:user).permit(:description)
	end

end
