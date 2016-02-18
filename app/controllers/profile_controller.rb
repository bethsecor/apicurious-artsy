class ProfileController < ApplicationController
  before_action :authorize!
  
  def show
    @info = SelfInfo.all(current_user.token)
    @media = SelfMedia.all(current_user.token)
  end
end
