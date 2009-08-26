class AddMobileCategory < ActiveRecord::Migration
	class Category < ActiveRecord::Base
	end
  def self.up
  add_column :categories, :mobile, :decimal, :precision => 1,:scale=> 0 , :default => 0
      Category.reset_column_information
    Category.update_all("mobile = 0")
  end

  def self.down
	remove_column :categories, :mobile  
  end
end
