class AddAlbumCoverArtAndRevenue < ActiveRecord::Migration[6.0]
  def change
    add_column :sales, :revenue, :float
    add_column :albums, :cover_art_url, :string
  end
end
