class SingleMedia
  def self.service
    InstagramService.new
  end

  def self.find(id, token)
    media = build_object(service.single_media(id, token)[:data])
    media.comments = service.comments(id, token)[:data]
    media.users_who_liked = service.likes(id, token)[:data]
    media
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end
end
