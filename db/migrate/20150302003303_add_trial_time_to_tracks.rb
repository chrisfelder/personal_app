class AddTrialTimeToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :trial_time, :integer
    add_column :tracks, :calibration_time, :integer
    add_column :tracks, :recalibration_time, :integer
  end
end
