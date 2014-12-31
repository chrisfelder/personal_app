class AddPreviousSaveStateToExperiments < ActiveRecord::Migration
  def change
    add_column :experiments, :previous_save_state, :string
  end
end
