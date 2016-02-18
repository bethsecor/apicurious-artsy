class Feed
  def self.service
    InstagramService.new
  end

  def followed_users(token)
    service.follows(token)[:data].map { |user| user[:id] }
  end

  def self.all(token)
    binding.pry
    user_ids = service.follows(token)[:data].map { |user| user[:id] }
    all_media = user_ids.map do |id|
      service.other_user_media(id, token).map { |media| build_object(media) }
    end
    all_media.flatten
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end
end
