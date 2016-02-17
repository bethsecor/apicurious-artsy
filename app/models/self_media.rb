class SelfMedia
  def self.service
    InstagramService.new
  end

  def self.all(token)
    service.user_media(token)[:data].map { |media| build_object(media) }
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end
end
