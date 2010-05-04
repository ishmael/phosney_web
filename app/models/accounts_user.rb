class AccountsUser < ActiveRecord::Base
belongs_to :user
belongs_to :account

def self.find_shared_accounts_users(*args)
  with_scope(:find => {:select => "distinct users.id,users.login ",:from => "accounts_users ,users",:conditions => "users.id = accounts_users.user_id"}) do
    find(*args)
  end
end
end
