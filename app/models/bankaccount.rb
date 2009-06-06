class Bankaccount < ActiveRecord::Base
  belongs_to :user
  has_many :movements, :dependent => :destroy
  
end
