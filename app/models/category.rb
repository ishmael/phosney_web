class Category < ActiveRecord::Base
acts_as_tree :order => "name"
belongs_to :user
has_many :movements, :dependent => :nullify
validates_presence_of :name

  def pseudo_id
    new_record? ? 0 : id
  end
end
