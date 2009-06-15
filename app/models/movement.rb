class Movement < ActiveRecord::Base
  belongs_to :account, :polymorphic => true
  validates_presence_of :description
  validates_numericality_of :amount
end
