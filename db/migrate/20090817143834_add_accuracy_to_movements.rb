class AddAccuracyToMovements < ActiveRecord::Migration
  def self.up
  add_column  :movements ,:accuracy ,:float , :default => nil
  end

  def self.down
  remove_column :movements, :accuracy
  end
end
