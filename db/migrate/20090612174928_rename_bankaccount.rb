class RenameBankaccount < ActiveRecord::Migration
  def self.up
     rename_table :bankaccounts, :accounts
  end

  def self.down
    rename_table  :accounts, :bankaccounts
  end
end
