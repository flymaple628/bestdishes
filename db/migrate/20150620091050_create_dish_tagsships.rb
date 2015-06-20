class CreateDishTagsships < ActiveRecord::Migration
  def change
    create_table :dish_tagsships do |t|
    	t.integer :tag_id,:dish_id
      t.timestamps null: false
    end
    add_index :dish_tagsships,:dish_id
  	add_index :dish_tagsships,:tag_id
  end
end
