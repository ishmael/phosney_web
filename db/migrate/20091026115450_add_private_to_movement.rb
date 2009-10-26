class AddPrivateToMovement < ActiveRecord::Migration
  def self.up
	  add_column :movements, :private, :decimal, :precision => 1,:scale=> 0 , :default => 0
	  Movement.reset_column_information
	  Movement.update_all("private = 0")
  end

  def self.down
	remove_column :movements, :private  
  end
end
