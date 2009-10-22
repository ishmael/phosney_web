class CreateAccountHolders < ActiveRecord::Migration
 def self.up
  create_table :account_holders do |t|
      t.integer :user_id,:null => false
      t.integer :account_id,:null => false
      t.decimal :allow_delete , :precision => 1,:scale=> 0 , :default => 0
      t.decimal :allow_edit , :precision => 1,:scale=> 0 , :default => 0
      t.decimal :allow_insert , :precision => 1,:scale=> 0 , :default => 1
      t.timestamps
    end
    
    execute "ALTER TABLE account_holders ADD CONSTRAINT account_holders_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id);"
    execute "ALTER TABLE account_holders ADD CONSTRAINT account_holders_account_id_fkey FOREIGN KEY (account_id) REFERENCES accounts (id);"
  end

  def self.down
    execute "ALTER TABLE account_holders DROP CONSTRAINT account_holders_user_id_fkey;"
    execute "ALTER TABLE account_holders DROP CONSTRAINT account_holders_account_id_fkey;"    
    drop_table :account_holders  
  end
end
