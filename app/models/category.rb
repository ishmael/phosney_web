class Category < ActiveRecord::Base
acts_as_tree :order => "name"
belongs_to :user
has_many :movements, :dependent => :nullify
validates_presence_of :name
validates_uniqueness_of :name, :scope => :user_id , :message =>  I18n.t('layout.categories.duplicate')
cattr_reader :per_page
default_scope :order => :name
 @@per_page = 10

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
