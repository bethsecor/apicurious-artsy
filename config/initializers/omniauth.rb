Rails.application.config.middleware.use OmniAuth::Builder do
  provider :instagram, ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET'],
          {:scope => "basic likes comments follower_list public_content relationships"}
end
