class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :strength
      t.integer :defense
      t.integer :hp_current
      t.integer :hp_max

      t.timestamps null: false
    end
  end
end
