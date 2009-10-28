class Movement < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :category
  acts_as_taggable
  validates_presence_of :description
  validates_numericality_of :amount
  
  def self.spending_data(*args)
    with_scope(:find => { :conditions => "movements.mov_type=-1"  , :select => "movements.account_id,movements.movdate,(select accounts.name from accounts where accounts.id = movements.account_id) as name,sum(movements.amount) as total",:group => "movements.account_id,movements.movdate"} ) do
      find(*args)
    end
  end
end
