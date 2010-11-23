class CreateAccountAttributes < ActiveRecord::Migration
  class AccountAttribute < ActiveRecord::Base
  end
  
  def self.up
    create_table :account_attributes do |t|
      t.integer :account_id,:null => false
      t.integer :attribute_type, :null => false
      t.string :value, :null => false
      t.timestamps
    end
     execute "ALTER TABLE account_attributes ADD CONSTRAINT account_attributes_account_id_fkey FOREIGN KEY (account_id) REFERENCES accounts (id);"
  end

  def self.down
    execute "ALTER TABLE account_attributes DROP CONSTRAINT account_attributes_account_id_fkey;"    
    drop_table :account_attributes
  end
end
