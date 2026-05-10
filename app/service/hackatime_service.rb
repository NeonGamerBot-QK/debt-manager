class HackatimeService
  BASE_URL = "https://hackatime.hackclub.com"
  # we dont got access tokens uwu
  def connection 
    Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end

  def fetch_stats(start_date, end_date)
    response = connection.get("users/#{hackatime_uid}/stats", params)
    return nil unless response.success?

    JSON.parse(response.body)
  end

end