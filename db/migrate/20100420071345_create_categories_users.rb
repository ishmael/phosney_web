class CreateCategoriesUsers < ActiveRecord::Migration
  class CategoriesUser < ActiveRecord::Base
  end

  def self.up
    create_table :categories_users do |t|
      t.integer :user_id,:null => false
      t.integer :category_id,:null => false
      t.timestamps
    end
     execute "ALTER TABLE categories_users ADD CONSTRAINT categories_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id);"
      execute "ALTER TABLE categories_users ADD CONSTRAINT categories_users_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories (id);"    
    @categories = Category.find(:all)
  	 @categories.each do |category| 
  	  @category = CategoriesUser.new
  	  @category.user_id = category.user_id
  	  @category.category_id = category.id
  	  @category.save
  	 end
  end

  def self.down
    drop_table :categories_users
  end
end
