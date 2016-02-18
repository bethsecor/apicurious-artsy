class Feed
  def self.service
    InstagramService.new
  end

  def self.all(token)
    service.follows(token)[:data].map do |user|
      build_object(media)
    end
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end
end
