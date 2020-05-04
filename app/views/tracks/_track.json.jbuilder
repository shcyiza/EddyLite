json.extract! track, :id, :artist_id, :isrc, :track_name, :created_at, :updated_at
json.url track_url(track, format: :json)
