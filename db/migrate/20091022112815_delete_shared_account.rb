class DeleteSharedAccount < ActiveRecord::Migration
  def self.up
      execute "ALTER TABLE shared_accounts DROP CONSTRAINT shared_accounts_user_id_fkey;"
    execute "ALTER TABLE shared_accounts DROP CONSTRAINT shared_accounts_account_id_fkey;"    
    drop_table :shared_accounts
  end

  def self.down
  create_table :shared_accounts do |t|
      t.integer :user_id,:null => false
      t.integer :account_id,:null => false
      t.decimal :allow_delete , :precision => 1,:scale=> 0 , :default => 0
      t.decimal :allow_edit , :precision => 1,:scale=> 0 , :default => 0
      t.decimal :allow_insert , :precision => 1,:scale=> 0 , :default => 1
      t.timestamps
    end
    
    execute "ALTER TABLE shared_accounts ADD CONSTRAINT shared_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id);"
    execute "ALTER TABLE shared_accounts ADD CONSTRAINT shared_accounts_account_id_fkey FOREIGN KEY (account_id) REFERENCES accounts (id);"    
  end
end
