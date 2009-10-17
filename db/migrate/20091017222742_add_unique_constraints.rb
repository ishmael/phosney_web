class AddUniqueConstraints < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE users ADD CONSTRAINT users_login_ukey UNIQUE (login);"
    execute "ALTER TABLE categories ADD CONSTRAINT categories_name_ukey UNIQUE (user_id,name);"
    execute "ALTER TABLE tags ADD CONSTRAINT tags_name_ukey UNIQUE (user_id,name);"            
  end

  def self.down
    execute "ALTER TABLE users DROP CONSTRAINT users_login_ukey;"
    execute "ALTER TABLE categories DROP CONSTRAINT categories_name_ukey;"
    execute "ALTER TABLE tags DROP CONSTRAINT tags_name_ukey;"
  end
end
