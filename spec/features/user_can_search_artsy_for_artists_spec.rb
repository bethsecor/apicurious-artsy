require 'rails_helper'

RSpec.feature "UserCanSearchArtsyForArtists", type: :feature do
  before do
    @user = OmniAuth.config.mock_auth[:instagram]
  end

  it "should bring me to a form to fill in search terms and then bring me to results" do
    visit root_path

    VCR.use_cassette("instagram_service#user_info") do
      click_on "Login with Instagram"
      service = InstagramService.new
      info = service.user_info(@user["credentials"]["token"])
    end

    click_on "Search"

    expect(current_path).to eq(new_search_path)

    VCR.use_cassette("artsy_service#artist") do
      fill_in "Artist", with: "Vincent Van Gogh"
      click_on "Search Artsy"

      expect(current_path).to eq(search_path)

      expect(page).to have_content("Vincent van Gogh")
      expect(page).to have_content("Born: 1853")
      expect(page).to have_content("Hometown: Zundert, Netherlands")
    end
  end

  it "should render new search and flash if resource not found on Artsy" do
    visit root_path

    VCR.use_cassette("instagram_service#user_info") do
      click_on "Login with Instagram"
      service = InstagramService.new
      info = service.user_info(@user["credentials"]["token"])
    end

    click_on "Search"

    expect(current_path).to eq(new_search_path)

    VCR.use_cassette("artsy_service#artist_invalid") do
      fill_in "Artist", with: "Vin"
      click_on "Search Artsy"

      expect(current_path).to eq(new_search_path)

      expect(page).to have_content('Could not find artist on Artsy')
    end
  end
end
