class AddForeignKeys < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE accounts ADD CONSTRAINT accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id);"
    execute "ALTER TABLE movements ADD CONSTRAINT movements_account_id_fkey FOREIGN KEY (account_id) REFERENCES accounts (id);"
    execute "ALTER TABLE movements ADD CONSTRAINT movements_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories (id);"
    execute "ALTER TABLE categories ADD CONSTRAINT categories_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id);"
    execute "ALTER TABLE tags ADD CONSTRAINT tags_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id);"
    execute "ALTER TABLE taggings ADD CONSTRAINT taggins_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES tags (id);"
  end

  def self.down
    execute "ALTER TABLE accounts DROP CONSTRAINT accounts_user_id_fkey;"
    execute "ALTER TABLE movements DROP CONSTRAINT movements_account_id_fkey;"
    execute "ALTER TABLE movements DROP CONSTRAINT movements_category_id_fkey;"
    execute "ALTER TABLE categories DROP CONSTRAINT categories_user_id_fkey;"    
    execute "ALTER TABLE tags DROP CONSTRAINT tag_user_id_fkey;"
    execute "ALTER TABLE taggings DROP CONSTRAINT taggins_tag_id_fkey;"
  end
end
