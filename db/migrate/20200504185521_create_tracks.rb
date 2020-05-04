class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.references :artist, null: false, foreign_key: true
      t.string :isrc
      t.string :track_name

      t.timestamps
    end
  end
end
