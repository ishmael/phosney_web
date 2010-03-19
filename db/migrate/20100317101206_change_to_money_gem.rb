class ChangeToMoneyGem < ActiveRecord::Migration
  def self.up
	  Movement.update_all("amount = amount *100")
    rename_column :movements, :amount, :amount_in_cents
    change_column :movements, :amount_in_cents, :integer, :default => 0
     
  end

  def self.down
    change_column :movements, :amount_in_cents, :decimal, :precision => 12, :scale => 2 , :default => 0
	  Movement.update_all("amount_in_cents = amount_in_cents / 100")
    rename_column :movements, :amount_in_cents, :amount

  end
end
