class ChangeAmountToBigint < ActiveRecord::Migration
  def self.up
      change_column :movements, :amount_in_cents, :integer, :default => 0,:limit => 8
          change_column :accounts, :balance_in_cents, :integer, :default => 0,:limit => 8
  end

  def self.down
    change_column :movements, :amount_in_cents, :integer, :default => 0
        change_column :accounts, :balance_in_cents, :integer, :default => 0
  end
end
