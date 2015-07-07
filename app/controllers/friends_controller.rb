class FriendsController < ApplicationController
	before_action :authenticate_user!

	#GET /friends/:id/request
	def box
		@friend_ship=Friendship.select("user_id").where("friendships.friend_id=? and friendships.status='ask'",current_user.id)
		@friends=User.where(:id=>@friend_ship)
	end
	#GET /friends/:id/request
  def ask
		Friendship.ask_friend(params[:id],params[:friend_id])
  	redirect_to '/user_list'
  end
	#GET /friends/:id/accept
  def accept

 		Friendship.friend_method(current_user.id,params[:id],'accept')
  	redirect_to :back
  end

	#GET /friends/:id/remove
  def remove
 		Friendship.remove_friend(params[:id],params[:friend_id])
  	redirect_to :back
  end

	#GET /friends/:id/reject
  def reject
 		Friendship.friend_method(current_user.id,params[:id],'reject')
  	redirect_to :back
  end

  protected

  def friend_params
  	#params.require(:)
  end
end
