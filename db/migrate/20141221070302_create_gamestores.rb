class CreateGamestores < ActiveRecord::Migration
  def change
    create_table :gamestores do |t|
      t.string :name
      t.integer :turn
      t.integer :char1
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :gamestores, [:user_id, :created_at]
  end
end
