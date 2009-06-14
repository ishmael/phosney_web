class AddAccountType < ActiveRecord::Migration
    class Account < ActiveRecord::Base
      end
      class BankAccount < Account 
      end
  def self.up
    add_column :accounts, :type, :string
    Account.reset_column_information
    Account.update_all("type = 'Bankaccount'")
  end

  def self.down
    remove_column :accounts, :account_type
  end
end
