class AddUserIdToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :user_id, :integer
    add_column :characters, :miner, :integer, default: 0
    add_column :characters, :lumberjack, :integer, default: 0
    add_column :characters, :hunter, :integer, default: 0
    add_column :characters, :builder, :integer, default: 0
    add_column :characters, :farmer, :integer, default: 0
    add_index :characters, :user_id
  end
end
