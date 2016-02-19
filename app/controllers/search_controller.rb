class SearchController < ApplicationController
  before_action :authorize!
  rescue_from Faraday::ResourceNotFound, with: :resource_not_found

  def new
  end

  def show
    if params[:artsy]
      @artist = ArtsyArtist.search(params[:artsy][:artist].parameterize)
    elsif params[:instagram]
      @media = TagMedia.all(params[:instagram][:tag].parameterize, current_user.token)
    end
  end


private

  def resource_not_found
    flash[:alert] = 'Could not find artist on Artsy'
    redirect_to new_search_path
  end
end
