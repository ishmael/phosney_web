class Movement < ActiveRecord::Base
  money :amount, :currency => :currency, :precision => 2
  belongs_to :user
  belongs_to :account
  belongs_to :category
  acts_as_taggable

  validates_presence_of :description,:account_id,:amount_in_cents
  validates_numericality_of :amount_in_cents
  cattr_reader :per_page
  @@per_page = 10
  
  
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
  
  
  def category_name
   if not category_id.nil?
     self.category.name
   end
     
  end

  
  def after_save
    if amount_in_cents_changed?
      self.account.balance_in_cents+= ( (amount_in_cents * mov_type ) - (amount_in_cents_was * mov_type_was ) )
      self.account.save
    end
  end
  
  def after_destroy
      self.account.balance_in_cents-=  (amount_in_cents * mov_type ) 
      self.account.save
  end
  

  
  def self.data_by_month(*args)
    with_scope(:find => { :conditions => "accounts_users.account_id = accounts.id and (movements.user_id = accounts_users.user_id  or (movements.private = 0 and movements.user_id <> accounts_users.user_id))"  , :select => "movements.account_id,movements.movdate,accounts.name,accounts.color,sum(movements.amount_in_cents) as amount_in_cents,movements.mov_type,movements.currency", :joins => "inner join accounts on accounts.id = movements.account_id inner join accounts_users on accounts_users.account_id = accounts.id",:group => "movements.account_id,movements.mov_type,movements.movdate,accounts.name,accounts.color,movements.currency"} ) do
      find(*args)
    end
  end
  
  def self.data_by_year(*args)
    with_scope(:find => {:select=> "accounts.id ,accounts.name,accounts.color,date_trunc('month',movdate) as movdate,sum(movements.amount_in_cents) as amount_in_cents,mov_type,movements.currency", :joins => "inner join accounts on accounts.id = movements.account_id inner join accounts_users on accounts_users.account_id = accounts.id",:conditions => "accounts_users.account_id = accounts.id and (movements.user_id = accounts_users.user_id  or (movements.private = 0 and movements.user_id <> accounts_users.user_id))" , :group => "date_trunc('month',movdate),accounts.id ,movements.currency,mov_type,accounts.name,accounts.color "}) do
      find(*args)
    end
  end
  
  def type_of_movement_desc
    case mov_type when -1 then I18n.t('layout.movements.debit') when 1 then I18n.t('layout.movements.credit') end 
  end
  
  def type_of_movement
    case mov_type when -1 then I18n.t('layout.movements.type_mov_debit') when 1 then I18n.t('layout.movements.type_mov_credit') end 
  end
  
end
