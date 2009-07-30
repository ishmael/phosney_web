class Category < ActiveRecord::Base
acts_as_tree :order => "name"
belongs_to :user
has_many :movements, :dependent => :nullify
end
