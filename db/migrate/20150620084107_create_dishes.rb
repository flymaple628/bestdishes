class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
    	t.integer :restaurant_id,:price,:viewed,:status,:user_id
    	t.string :short_des,:name

      t.timestamps null: false
    end

    add_index :dishes,:user_id
  end
end
