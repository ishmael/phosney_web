class ChangeAccountHolder < ActiveRecord::Migration
  def self.up
  rename_table :account_holders, :accounts_users
  end

  def self.down
  rename_table  :accounts_users,:account_holders
  end
end
