class AddBalanceAndCurrency < ActiveRecord::Migration
  def self.up
    add_column :accounts, :balance_in_cents, :integer, :default => 0
    add_column :accounts, :currency, :string
    Account.update_all("balance_in_cents = coalesce((select sum(amount_in_cents*mov_type) from movements where account_id = accounts.id),0) ")
    Account.update_all("currency = 'EUR'")
  end

  def self.down
    remove_column :accounts, :balance_in_cents
    remove_column :accounts, :currency    
  end
end
