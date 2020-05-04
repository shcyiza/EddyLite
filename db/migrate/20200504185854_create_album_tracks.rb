class CreateAlbumTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :album_tracks do |t|
      t.references :track, null: false, foreign_key: true
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
