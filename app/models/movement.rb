class Movement < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :category
  acts_as_taggable
  validates_presence_of :description,:account_id
  validates_numericality_of :amount
  
  def category_id=(category)
    if category  == "0" 
      write_attribute(:category_id,nil)
    else
      write_attribute(:category_id, category)
    end
  end
  
  def category_id
    category = read_attribute(:category_id)
    if category  == "0" 
      nil
    else
      category
    end
  end
  
  def self.data_by_month(*args)
    with_scope(:find => { :conditions => "accounts_users.account_id = accounts.id and (movements.user_id = accounts_users.user_id  or (movements.private = 0 and movements.user_id <> accounts_users.user_id))"  , :select => "movements.account_id,movements.movdate,accounts.name,sum(movements.amount) as total", :joins => "inner join accounts on accounts.id = movements.account_id inner join accounts_users on accounts_users.account_id = accounts.id",:group => "movements.account_id,movements.movdate,accounts.name"} ) do
      find(*args)
    end
  end
  
  def self.data_by_year(*args)
    with_scope(:find => {:select=> "date_trunc('month',movdate) as movdate,sum(movements.amount) as balance,mov_type", :joins => "inner join accounts on accounts.id = movements.account_id inner join accounts_users on accounts_users.account_id = accounts.id",:conditions => "accounts_users.account_id = accounts.id and (movements.user_id = accounts_users.user_id  or (movements.private = 0 and movements.user_id <> accounts_users.user_id))" , :group => "date_trunc('month',movdate),mov_type"}) do
      find(*args)
    end
  end
  
  
  def type_of_movement
    case mov_type when -1 then I18n.t('layout.movements.type_mov_debit') when 1 then I18n.t('layout.movements.type_mov_credit') end 
  end
  
end
