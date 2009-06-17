class AddUserLocale < ActiveRecord::Migration
  def self.up
  add_column :users, :locale, :string 
  User.update_all("locale = 'pt'")
  end

  def self.down
  remove_column :users, :locale 
  end
end
