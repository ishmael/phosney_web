class Movement < ActiveRecord::Base
  belongs_to :account
  belongs_to :category
  validates_presence_of :description
  validates_numericality_of :amount
end
