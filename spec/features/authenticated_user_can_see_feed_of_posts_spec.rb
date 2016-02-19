require 'rails_helper'

RSpec.feature "AuthenticatedUserCanSeeFeedOfPosts", type: :feature do
  before do
    @user = OmniAuth.config.mock_auth[:instagram]
  end

  it "should see posts from the users they follow" do
    visit root_path

    VCR.use_cassette("instagram_service#user_info") do
      click_on "Login with Instagram"
      service = InstagramService.new
      info = service.user_info(@user["credentials"]["token"])
    end

    VCR.use_cassette("instagram_service#feed") do
      click_on "Artful Dodger"
      expect(current_path).to eq(feed_path)
      posts = Feed.all(@user["credentials"]["token"])
      first_post = posts.first

      within(".post-#{first_post.id}") do
        expect(page).to have_content("penneylicious")
        expect(page).to have_content("9 likes")
        expect(page).to have_content("Another beautiful day at the crag")
      end

      last_post = posts.last

      within(".post-#{last_post.id}") do
        expect(page).to have_content("justinpease1")
        expect(page).to have_content("1 like")
        expect(page).to have_content("Love the message!")
      end
    end
  end
end
