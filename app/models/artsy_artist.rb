class ArtsyArtist
  def self.service
    ArtsyService.new
  end

  def self.search(search_term)
    service.artist(search_term)
  end
end
