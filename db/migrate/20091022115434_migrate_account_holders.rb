class MigrateAccountHolders < ActiveRecord::Migration
  class AccountHolder < ActiveRecord::Base
    end
  def self.up
	@account = Account.find(:all)
	 @account.each do |account| 
	  @accountholder = AccountHolder.new
	  @accountholder.user_id = account.user_id
	  @accountholder.account_id = account.id
	  @accountholder.allow_delete = 1
      @accountholder.allow_edit = 1
      @accountholder.allow_insert  = 1
	  @accountholder.save
	 end
  end

  def self.down
   AccountHolder.delete_all
  end
end
