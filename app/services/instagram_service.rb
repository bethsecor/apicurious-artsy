class InstagramService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "https://api.instagram.com/v1")
  end

  def user_media(token)
    parse(connection.get("users/self/media/recent", { access_token: token }))
  end

  def user_info(token)
    parse(connection.get("users/self", { access_token: token }))
  end

  def single_media(id, token)
    parse(connection.get("media/#{id}", { access_token: token }))
  end

  def comments(id, token)
    parse(connection.get("media/#{id}/comments", { access_token: token }))
  end

  def likes(id, token)
    parse(connection.get("media/#{id}/likes", { access_token: token }))
  end

  # def follows(token)
  #   parse(connection.get("users/self/follows", { access_token: token }))
  # end

  # def tag_media(tag_name, token)
  #   parse(connection.get("tags/#{tag_name}/media/recent", { access_token: token }))
  # end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
