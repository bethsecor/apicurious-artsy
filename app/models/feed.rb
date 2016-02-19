class Feed
  def self.service
    InstagramService.new
  end

  def self.all(token)
    user_ids = service.follows(token)[:data].map { |user| user[:id] }
    all_media = user_ids.map do |id|
      service.other_user_media(id, token)[:data].map { |media| build_object(media) }
    end
    all_media.flatten.sort_by { |post| -post.created_time.to_i }
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end
end
