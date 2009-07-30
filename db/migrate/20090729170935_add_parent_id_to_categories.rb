class AddParentIdToCategories < ActiveRecord::Migration
  def self.up
  add_column :categories, :parent_id, :integer , :default => 0
  end

  def self.down
  remove_column :categories, :parent_id
  end
end
