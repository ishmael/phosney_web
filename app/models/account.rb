class Account < ActiveRecord::Base
  has_many :accounts_users, :dependent => :destroy
  has_many :users , :through => :accounts_users
  has_many :movements, :dependent => :destroy
  has_many :shared_account_invitations, :dependent => :destroy
  
end
