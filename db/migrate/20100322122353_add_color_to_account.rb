class AddColorToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :color, :string, :default => '000000'
    Account.update_all("color = '000000'")
  end

  def self.down
    remove_column :accounts, :color   
  end
end
