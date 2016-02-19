require 'rails_helper'

RSpec.feature "AuthenticatedUserCanSeeDetailsOfPosts", type: :feature do
  before do
    @user = OmniAuth.config.mock_auth[:instagram]
  end

  it "should for a post show photo and likes and comments" do
    visit root_path

    VCR.use_cassette("instagram_service#user_info") do
      click_on "Login with Instagram"
      service = InstagramService.new
      info = service.user_info(@user["credentials"]["token"])
    end

    VCR.use_cassette("instagram_service#self_media") do
      service = InstagramService.new
      media = service.user_media(@user["credentials"]["token"])
      second_post = media[:data][1]

      expect(media[:data].length).to eq(3)

      VCR.use_cassette("instagram_service#single_media") do
        page.find("#media-#{second_post[:id]}").click
        post = SingleMedia.find(second_post[:id], @user["credentials"]["token"])

        expect(page).to have_content("3 likes")

        post.comments.each do |comment|
          expect(page).to have_content(comment[:text])
        end
      end
    end
  end
end
