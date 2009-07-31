class User < ActiveRecord::Base  
  acts_as_authentic 
  has_many :bankaccounts, :dependent => :destroy
  has_many :loanaccounts, :dependent => :destroy
  has_many :creditcardaccounts, :dependent => :destroy
  has_many :categories, :dependent => :destroy
  has_many :tags, :dependent => :destroy 
  #has_many :accounts, :dependent => :destroy
  #do |c|
  #      c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
  #    end # block optional
end
