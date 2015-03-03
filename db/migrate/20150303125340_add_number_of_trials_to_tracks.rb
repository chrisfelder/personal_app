class AddNumberOfTrialsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :number_of_trials, :integer
  end
end
