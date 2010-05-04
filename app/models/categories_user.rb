class CategoriesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates_uniqueness_of :category_id, :scope => :user_id , :message =>  I18n.t('layout.categoriesusers.duplicate')
  validates_presence_of :user_id
  
  def before_destroy
    category = Category.find category_id
    if category.user_id != user_id
      new_category = Category.find(:first, :conditions => ["user_id = ?  and name = ?",user_id,category.name])
      if not new_category
        new_category = Category.new
        new_category.user_id = user_id
        new_category.name = category.name
        new_category.mobile = category.mobile
        new_category.save
      end
      Movement.update_all(["category_id = ?",new_category.id],["user_id= ? and category_id = ?",user_id,category.id])
    end
  end
  
  
end
