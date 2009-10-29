class Account < ActiveRecord::Base
  has_many :accounts_users, :dependent => :destroy
  has_many :users , :through => :accounts_users
  has_many :movements, :dependent => :destroy
  has_many :shared_account_invitations, :dependent => :destroy
  
  def self.find_accounts_with_balance(*args)
      with_scope(:find => {:select => "accounts.id,accounts.name, accounts.bank,(select sum(amount*mov_type) from movements where movements.account_id = accounts.id and (movements.user_id = accounts_users.user_id  or (movements.private = 0 and movements.user_id <> accounts_users.user_id))) as balance, accounts_users.allow_insert,accounts_users.allow_edit,accounts_users.allow_delete,accounts_users.owner",:order => "accounts.name asc"}) do
        find(*args)
      end
  end
  
  def self.find_accounts(*args)
      with_scope(:find => {:select => "accounts.*,accounts_users.allow_insert,accounts_users.allow_edit,accounts_users.allow_delete,accounts_users.owner",:order => "accounts.name asc"}) do
        find(*args)
      end
  end
end
