class User < ActiveRecord::Base  
  acts_as_authentic 
  has_many :accounts_users, :dependent => :destroy
  has_many :movements, :dependent => :destroy
  has_many :accounts,:through => :accounts_users,:source => :account, :dependent => :destroy  
  has_many :bankaccounts,:through => :accounts_users,:source => :account,:class_name => 'Bankaccount', :dependent => :destroy
  has_many :loanaccounts,:through => :accounts_users,:source => :account,:class_name => 'Loanaccount', :dependent => :destroy
  has_many :creditcardaccounts, :through => :accounts_users,:source => :account,:class_name => 'Creditcardaccount', :dependent => :destroy
  has_many :categories_users, :dependent => :destroy
  has_many :categories,:through => :categories_users, :dependent => :destroy
  has_many :tags, :dependent => :destroy 



    
  def deliver_password_reset_instructions!
	reset_perishable_token!
	Notifier.deliver_password_reset_instructions(self)
  end
  
  def last_login
    if (not last_login_at.nil?)
     I18n.l last_login_at, :format => :short
    else
     I18n.t('layout.users.lastlogin')
    end
  end
  

  
end
