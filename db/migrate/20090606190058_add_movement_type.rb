class AddMovementType < ActiveRecord::Migration
  def self.up
      add_column :movements, :mov_type, :decimal, :precision => 1,:scale=> 0 , :default => 1
  end

  def self.down
    remove_column :movements, :mov_type
  end
end
