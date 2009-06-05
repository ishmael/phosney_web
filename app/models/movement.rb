class Movement < ActiveRecord::Base
  belongs_to :bankaccount
  validates_presence_of :description
  validates_numericality_of :amount
end
