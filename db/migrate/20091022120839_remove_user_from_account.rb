class RemoveUserFromAccount < ActiveRecord::Migration
	class Account < ActiveRecord::Base
    end
  def self.up
	remove_column :accounts, :user_id
  end

  def self.down
	add_column :accounts, :user_id, :integer ,:null => false
	Account.reset_column_information
	@accountholder = AccountHolder.find(:all)
	@accountholder.each do |accounth| 
		Account.update(accounth.account_id,:user_id => accounth.user_id)
	end
  end
end
