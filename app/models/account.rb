class Account < ActiveRecord::Base

  has_many :accounts_users, :dependent => :destroy
  has_many :users , :through => :accounts_users
  has_many :movements, :dependent => :destroy
  has_many :shared_account_invitations, :dependent => :destroy
  validates_presence_of :name, :number,:bank
  money :balance, :currency => :currency,:precision => 2
  
  def self.find_accounts_with_balance(*args)
      with_scope(:find => {:select => "accounts.*, accounts_users.allow_insert,accounts_users.allow_edit,accounts_users.allow_delete,accounts_users.owner",:order => "accounts.name asc"}) do
        find(*args)
      end
  end
  
  def self.find_accounts(*args)
      with_scope(:find => {:select => "accounts.*,accounts_users.allow_insert,accounts_users.allow_edit,accounts_users.allow_delete,accounts_users.owner",:order => "accounts.name asc"}) do
        find(*args)
      end
  end
  
  def self.find_accounts_insert(*args)
    with_scope(:find => {:select => "accounts.*,accounts_users.allow_insert,accounts_users.allow_edit,accounts_users.allow_delete,accounts_users.owner",:conditions =>  'accounts_users.allow_insert =1',:order => "accounts.name asc"}) do
      find(*args)
    end
  end
  

  
  def pseudo_id
    new_record? ? 0 : id
  end
  
  def after_save
    if currency_changed?
      self.movements.update_all("currency ='" + currency + "'")
    end
  end
  
  
end
