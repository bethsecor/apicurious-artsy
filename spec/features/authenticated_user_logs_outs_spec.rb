require 'rails_helper'

RSpec.feature "AuthenticatedUserLogsOuts", type: :feature do
  before do
    @user = OmniAuth.config.mock_auth[:instagram]
  end

  it "should redirect to homepage after logging out" do
    visit root_path

    VCR.use_cassette("instagram_service#user_info") do
      click_on "Login with Instagram"
      service = InstagramService.new
      info = service.user_info(@user["credentials"]["token"])

      expect(info[:data][:username]).to eq("miss.capybara")
      expect(current_path).to eq profile_path
      click_on "Logout"
    end

    expect(current_path).to eq root_path

    visit profile_path

    expect(current_path).to eq root_path
  end
end
