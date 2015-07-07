class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend


	def self.remove_friend(id,friend_id)
		self.find_by_user_id_and_friend_id(id,friend_id).destroy()
 		#self.find_by_user_id_and_friend_id(friend_id,id).destroy()
	end

	def self.ask_friend(id,friend_id)
		self.create(:user_id=>id,:friend_id=>friend_id,:status=>'ask')
		#self.create(:user_id=>friend_id,:friend_id=>id,:status=>'ask')
	end
	def self.friend_method(id,friend_id,status)
		logger.info "id==#{id};friend_id==#{friend_id};status==#{status}"
		friend=self.find_by_user_id_and_friend_id(friend_id,id)
		friend.update(:friend_id=>id,:id=>friend_id,:status=>status)
		self.create(:user_id=>id,:friend_id=>friend_id,:status=>status)
		# self.save()
		#self.update(:user_id=>friend_id,:friend_id=>id,:status=>status)
	end
end
