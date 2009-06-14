class ChangeMovementsBankaccountId < ActiveRecord::Migration
  def self.up
    rename_column :movements, :bankaccount_id, :account_id
  end

  def self.down
    rename_column :movements, :account_id, :bankaccount_id
  end
end
