class CreateBankaccounts < ActiveRecord::Migration
  def self.up
    create_table :bankaccounts do |t|
      t.integer :user_id,:null => false
      t.string :name
      t.string :number
      t.string :bank
      
      t.datetime :created_at      
      t.datetime :updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :bankaccounts
  end
end
