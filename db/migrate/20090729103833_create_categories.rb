class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
	  t.string :name, :null => false
	  t.integer :user_id,:null => false
      t.timestamps
    end
	add_column :movements, :category_id, :integer 
  end

  def self.down
	remove_column :movements, :category_id
    drop_table :categories
  end
end
