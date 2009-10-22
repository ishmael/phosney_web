class AddAccountUserOwner < ActiveRecord::Migration
  def self.up
	add_column :accounts_users, :owner, :decimal , :precision => 1,:scale=> 0 , :default => 0
	AccountsUser.reset_column_information
    AccountsUser.update_all("owner = 1")
	
  end

  def self.down
	remove_column :accounts_users, :owner
  end
end
