class ApiController < ApplicationController

  def artist_tracks
    tracks = Track.includes(:albums).where(artist_id: params[:artist_id]).map do |t|
      hash = t.as_json(root: false)
      hash['releases'] = t.albums
      hash
    end

    render json: tracks, status: :ok
  end

  def artist_revenues
    artist = Artist.find(params[:artist_id])
    statement = artist.make_statement

    render json: statement, status: :ok
  end
end
