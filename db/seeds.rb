# frozen_string_literal: true

def import_assignments_data(json_name)
  path = File.join(File.dirname(__FILE__), "../assignment-files/#{json_name}")
  JSON.parse(File.read(path))
end

def to_be_inserted(collection, instance)
  unless instance.persisted?
    new_hash = instance.as_json(root: false).compact
    new_hash['created_at'] = Time.now
    new_hash['updated_at'] = Time.now
    collection.push new_hash
  end
end

def bulk_insert(inserting_class, collection)
  inserting_class.insert_all collection if collection.count > 0
end

track_records = import_assignments_data('tracks.json')
sales_records = import_assignments_data('sales-report.json')

seeded_artist = {}
seeded_albums = {}

track_records.each do |record|
  next if record.values.include?('')

  p "processing tracks #{record}..."

  # procces artist
  artist_name = record['Artist Name']
  artist = seeded_artist[artist_name]
  if artist.nil?
    p "Adding Artist#{artist_name}..."
    artist = Artist.find_or_create_by name: artist_name
    seeded_artist[artist_name] = artist
    p 'ok'
  end
  # procces album
  album_upc = record['UPC']
  album = seeded_albums[album_upc]
  if album.nil?
    p "Adding album #{album_upc}"
    album = Album.find_or_create_by(
      upc: album_upc,
      release_title: record['Release title'],
      cover_art_url: record['Cover Art'],
      year: record['Release year'],
      artist: artist
    )
    seeded_albums[album_upc] = album
    p 'ok'
  end
  # procces tracks
  track_isrc = record['ISRC']
  p "Adding track #{track_isrc}"
  track = Track.find_or_create_by(
    isrc: track_isrc,
    title: record['Track Title'],
    artist: artist
  )
  p 'ok'
  # procces album track
  AlbumTrack.find_or_create_by album: album, track: track
end

sales_to_insert = []

p 'Processing with sales...'
sales_records.each do |record|
  next if record.values.include?('')

  sale = Sale.init_from_json record
  to_be_inserted sales_to_insert, sale
end

bulk_insert Sale, sales_to_insert
p "#{sales_to_insert.count} sales transaction inserted"
