class AddUserIdToMovement < ActiveRecord::Migration

  def self.up
	add_column :movements, :user_id, :integer 
	Movement.reset_column_information
	@movs = Movement.find(:all)
	@movs.each do |mov| 
		@acc = AccountsUser.find_by_sql ["select * from accounts_users where accounts_users.owner = 1 and accounts_users.account_id = ?",mov.account_id]
		Movement.update(mov.id,:user_id => @acc[0].user_id)
	end
	change_column :movements, :user_id, :integer , :null => false	
execute "ALTER TABLE movements ADD CONSTRAINT movements_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id);"	
  end

  def self.down
  execute "ALTER TABLE movements DROP CONSTRAINT movements_user_id_fkey;"
  remove_column :movements, :user_id
  end
end
	