class ArtsyService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "https://api.artsy.net/api")
  end

  def artsy_token
    parse(connection.post("tokens/xapp_token", { client_id: ENV['ARTSY_ID'],client_secret: ENV['ARTSY_SECRECT'] }))[:token]
  end

  def artist(search_term)
    artsy_api = Hyperclient.new('https://api.artsy.net/api') do |api|
      api.headers['Accept'] = 'application/vnd.artsy-v2+json'
      api.headers['X-Xapp-Token'] = artsy_token
      api.connection(default: false) do |conn|
        conn.use FaradayMiddleware::FollowRedirects
        conn.use Faraday::Response::RaiseError
        conn.request :json
        conn.response :json, content_type: /\bjson$/
        conn.adapter :net_http
      end
    end
    artsy_api.artist(id: search_term)
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
