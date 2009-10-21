class Account < ActiveRecord::Base
  
  belongs_to :user
  has_many :movements, :dependent => :destroy
  has_many :shared_accounts, :dependent => :destroy
  has_many :shared_account_invitations, :dependent => :destroy
  
end
