# frozen_string_literal: true

class ArtistsController < ApplicationController
  # GET /artists
  # GET /artists.json
  def index
    @artists = Artist.all
  end
end
