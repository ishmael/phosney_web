class AddUserToTag < ActiveRecord::Migration
  def self.up
  add_column :tags, :user_id, :integer ,:null => false
  end

  def self.down
  remove_column :tags, :user_id
  end
end
