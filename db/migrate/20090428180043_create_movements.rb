class CreateMovements < ActiveRecord::Migration
  def self.up
    create_table :movements do |t|
      t.integer :bankaccount_id
      t.string :description
      t.decimal :amount, :precision => 12, :scale => 2 , :default => 0
      t.datetime :movdate
      t.datetime :created_at
      t.datetime :created_on
      t.datetime :updated_at
      t.datetime :updated_on 
      t.timestamps
    end
  end

  def self.down
    drop_table :movements
  end
end
