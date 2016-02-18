require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  before do
    @user = OmniAuth.config.mock_auth[:instagram]
  end

  it "should redirect to profile page after logging in" do
    visit root_path

    VCR.use_cassette("instagram_service#user_info") do
      click_on "Login with Instagram"
      service = InstagramService.new
      info = service.user_info(@user["credentials"]["token"])

      expect(info[:data][:username]).to eq("miss.capybara")
      expect(current_path).to eq profile_path
    end

    VCR.use_cassette("instagram_service#self_media") do
      service = InstagramService.new
      media = service.user_media(@user["credentials"]["token"])

      expect(media[:data].length).to eq(3)
    end
  end
end
