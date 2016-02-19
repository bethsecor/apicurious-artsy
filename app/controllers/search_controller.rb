class SearchController < ApplicationController
  def new
  end

  def show
    if params[:artsy]
      @artist = ArtsyArtist.search(params[:artsy][:artist].parameterize)
    elsif params[:instagram]
      @media = TagMedia.all(params[:instagram][:tag].parameterize, current_user.token)
    end
  end
end
