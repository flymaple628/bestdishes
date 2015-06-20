class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.integer :dish_id,:user_id,:acid,:sweet,:bitter,:spicy,:salt,:tasted,:orderby
      t.string :comment
      t.timestamps null: false
    end
    add_index :comments,:dish_id
    add_index :comments,:user_id
  end
end
