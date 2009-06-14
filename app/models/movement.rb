class Movement < ActiveRecord::Base
  belongs_to :account
  validates_presence_of :description
  validates_numericality_of :amount
end
