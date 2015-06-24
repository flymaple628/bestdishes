class EditDraftCol < ActiveRecord::Migration
  def change
  	add_column :comments, :status, :string
  	remove_column :dishes, :status
  	add_column :dishes, :status, :string
  end
end
