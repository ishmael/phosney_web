class User < ActiveRecord::Base  
  acts_as_authentic 
  has_many :accounts_users
  has_many :bankaccounts,:through => :accounts_users,:source => :account,:class_name => 'Bankaccount'
  has_many :loanaccounts,:through => :accounts_users,:source => :account,:class_name => 'Loanaccount'
  has_many :creditcardaccounts, :through => :accounts_users,:source => :account,:class_name => 'Creditcardaccount'
  has_many :categories, :dependent => :destroy
  has_many :tags, :dependent => :destroy 
  #has_many :accounts, :dependent => :destroy
  #do |c|
  #      c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
  #    end # block optional
  
  def deliver_password_reset_instructions!
	reset_perishable_token!
	Notifier.deliver_password_reset_instructions(self)
  end
  
end
