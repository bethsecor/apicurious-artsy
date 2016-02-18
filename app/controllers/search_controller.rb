class SearchController < ApplicationController
  def new
  end

  def show
    @artist = ArtsyArtist.search(params[:artsy][:artist].parameterize)
  end
end
