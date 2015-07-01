class AddColumnsToDishes < ActiveRecord::Migration
  def change
  	add_column :dishes, :comments_count, :integer, :default => 0
  	add_column :dishes, :last_commented_at, :datetime

  	Dish.all.each do |d|
  		d.comments_count = d.comments.count
  		d.last_commented_at = d.comments.order("id DESC").first.try(:created_at)
  		d.save
  	end

  end
end
