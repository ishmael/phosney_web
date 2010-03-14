class Category < ActiveRecord::Base
acts_as_tree :order => "name"
belongs_to :user
has_many :movements, :dependent => :nullify
validates_presence_of :name

  def parent_id=(parent)
    if parent  == "0" 
      write_attribute(:parent_id,nil)
    else
      write_attribute(:parent_id, parent)
    end
  end

  def parent_id
    parent = read_attribute(:parent_id)
    if parent  == "0" 
      nil
    else
      parent
    end
  end

  def pseudo_id
    new_record? ? 0 : id
  end
end
