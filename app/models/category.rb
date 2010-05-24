class Category < ActiveRecord::Base

belongs_to :user
has_many :categories_users, :dependent => :destroy
has_many :movements, :dependent => :nullify
has_many :users, :through => :categories_users
validates_presence_of :name
validates_uniqueness_of :name, :scope => :user_id , :message =>  I18n.t('layout.categories.duplicate')
default_scope :order => :name
named_scope :sharedcats,  :select =>  "categories.id, case when categories.user_id = categories_users.user_id then categories.name when categories.user_id <> categories_users.user_id then categories.name || '(' || (select users.login from users where users.id = categories.user_id) || ')' end as name,categories.user_id,categories.created_at,categories.updated_at,categories.parent_id,categories.mobile",:joins => "INNER JOIN categories_users ON categories.id = categories_users.category_id"

acts_as_tree :order => "name"




  def self.shared(*args)
      with_scope(:find => {:select => "categories.id, case when categories.user_id = categories_users.user_id then categories.name when categories.user_id <> categories_users.user_id then categories.name || '(' || (select users.login from users where users.id = categories.user_id) || ')' end as name,categories.user_id,categories.created_at,categories.updated_at,categories.parent_id,categories.mobile" }) do
         find(*args)
      end
  end

 

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
