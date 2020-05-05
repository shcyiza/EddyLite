class ChangeTrackNameToName < ActiveRecord::Migration[6.0]
  def change
    rename_column :tracks, :track_name, :title
  end
end
