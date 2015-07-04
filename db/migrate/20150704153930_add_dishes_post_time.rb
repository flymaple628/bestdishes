class AddDishesPostTime < ActiveRecord::Migration
  def change
  	add_column :dishes,:book_time,:datetime
  end
end
