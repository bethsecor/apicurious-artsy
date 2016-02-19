require 'rails_helper'

RSpec.feature "AuthenticatedUserCanSearchInstagramForATags", type: :feature do
  before do
    @user = OmniAuth.config.mock_auth[:instagram]
  end

  it "should bring me to a form to fill in search terms and then bring me to results" do
    visit root_path

    VCR.use_cassette("instagram_service#user_info") do
      click_on "Login with Instagram"
    end

    click_on "Search"

    expect(current_path).to eq(new_search_path)

    VCR.use_cassette("instagram_service#tag_media") do
      fill_in "Tag", with: "capybara"
      click_on "Search Instagram"

      expect(current_path).to eq(search_path)

      expect(page).to have_content("Search Results from Instagram")
    end
  end
end
