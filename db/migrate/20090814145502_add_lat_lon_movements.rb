class AddLatLonMovements < ActiveRecord::Migration
  def self.up
     add_column  :movements ,:lat ,:float , :default => nil
	 add_column  :movements ,:lng ,:float , :default => nil
  end

  def self.down
  remove_column :movements, :lat
  remove_column :movements, :lng
  end
end
