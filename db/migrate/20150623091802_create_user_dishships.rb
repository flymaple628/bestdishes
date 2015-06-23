class CreateUserDishships < ActiveRecord::Migration
  def change
    create_table :user_dishships do |t|
    	t.integer :user_id
    	t.integer :dish_id

      t.timestamps null: false
    end
    add_index :user_dishships,:user_id
    add_index :user_dishships,:dish_id
  end
end
