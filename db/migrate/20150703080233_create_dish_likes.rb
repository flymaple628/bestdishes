class CreateDishLikes < ActiveRecord::Migration
  def change
    create_table :dish_likes do |t|
    	t.integer :user_id ,:index=>true
    	t.integer :dish_id ,:index=>true

      t.timestamps null: false
    end
    add_column :dishes,:like_count,:integer, :default => 0

  end
end
