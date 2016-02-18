class ArtsyArtist
  def self.service
    ArtsyService.new
  end

  def self.search(search_term)
    service.artist(search_term)
  end

  private

  def self.build_object(data)
    OpenStruct.new(data)
  end
end
