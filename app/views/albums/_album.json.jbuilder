json.extract! album, :id, :artist_id, :upc, :release_title, :year, :created_at, :updated_at
json.url album_url(album, format: :json)
