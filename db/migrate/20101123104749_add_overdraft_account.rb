class AddOverdraftAccount < ActiveRecord::Migration
  def self.up
        add_column :accounts, :overdraft_in_cents, :integer, :default => 0
        Account.update_all("overdraft_in_cents = 0")
  end

  def self.down
        remove_column :accounts, :overdraft_in_cents
  end
end
