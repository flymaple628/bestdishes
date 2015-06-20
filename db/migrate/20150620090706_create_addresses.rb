class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
    	t.integer :restaurant_id
    	t.string :address

      t.timestamps null: false
    end
  add_index :addresses,:restaurant_id
  end
end
