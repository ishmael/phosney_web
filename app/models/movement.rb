class Movement < ActiveRecord::Base

  belongs_to :account
  belongs_to :category
  acts_as_taggable
  validates_presence_of :description
  validates_numericality_of :amount
  

end
