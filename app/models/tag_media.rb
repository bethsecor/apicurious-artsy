class TagMedia
  def self.service
    InstagramService.new
  end

  def self.all(tag_name, token)
    service.tag_media(tag_name, token)[:data].map { |media| build_object(media) }
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end
end
