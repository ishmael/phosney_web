class CreateSharedAccountInvitations < ActiveRecord::Migration
  def self.up
    create_table :shared_account_invitations do |t|
      t.integer :user_id,:null => false
      t.string :recipient_email
      t.string :token
      t.integer :account_id,:null => false
      t.decimal :allow_delete , :precision => 1,:scale=> 0 , :default => 0
      t.decimal :allow_edit , :precision => 1,:scale=> 0 , :default => 0
      t.decimal :allow_insert , :precision => 1,:scale=> 0 , :default => 1
      t.datetime :sent_at
      t.timestamps
    end
    
    execute "ALTER TABLE shared_account_invitations ADD CONSTRAINT shared_account_invitations_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id);"
    execute "ALTER TABLE shared_account_invitations ADD CONSTRAINT shared_account_invitations_account_id_fkey FOREIGN KEY (account_id) REFERENCES accounts (id);"
  end

  def self.down
    execute "ALTER TABLE shared_account_invitations DROP CONSTRAINT shared_account_invitations_user_id_fkey;"
    execute "ALTER TABLE shared_account_invitations DROP CONSTRAINT shared_account_invitations_account_id_fkey;"    
    drop_table :shared_account_invitations
  end
end
