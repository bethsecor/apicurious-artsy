class PhotosController < ApplicationController
  before_action :authorize!

  def show
    @photo = SingleMedia.find(params[:id], current_user.token)
    @likers = @photo.users_who_liked.map { |user| user[:username] }.join(", ")
  end
end
