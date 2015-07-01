class AddDefaultToDishViewed < ActiveRecord::Migration
  def change
  	change_column :dishes, :viewed, :integer, :default => 0
  end
end
