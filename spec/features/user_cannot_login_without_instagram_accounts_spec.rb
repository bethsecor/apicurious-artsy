require 'rails_helper'

RSpec.feature "UserCannotLoginWithoutInstagramAccounts", type: :feature do
  before do
    OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new({
  :provider => 'instagram',
  :uid => '123545321',
  :credentials => {token: "fake"}
  })
  end

  it "should not be able to get to profile page with invalid credentials" do
    skip
    visit root_path

    VCR.use_cassette("instagram_service#user_info") do
      click_on "Login with Instagram"
    end

    expect(current_path).to eq(root_path)
  end
end
