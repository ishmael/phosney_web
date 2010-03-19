class AddCurrencyToMovements < ActiveRecord::Migration
  def self.up
    add_column :movements, :currency, :string
    Movement.update_all("currency = 'EUR'")
  end

  def self.down
    remove_column :movements, :currency    
  end
end
