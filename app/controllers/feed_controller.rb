class FeedController < ApplicationController
  before_action :authorize!

  def show
    @feed = Feed.all(current_user.token)
  end
end
