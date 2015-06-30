class AddPicDish < ActiveRecord::Migration
	def up
	    add_attachment :dishes, :realpic
	end
end
