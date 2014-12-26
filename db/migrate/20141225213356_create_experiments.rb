class CreateExperiments < ActiveRecord::Migration
  def change
    create_table :experiments do |t|
      t.string :save_state

      t.timestamps null: false
    end
    add_index :experiments, :save_state
  end
end
