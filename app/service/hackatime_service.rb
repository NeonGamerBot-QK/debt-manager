class HackatimeService
  BASE_URL = "https://hackatime.hackclub.com"

  def initialize(slack_id)
    @slack_id = slack_id
  end

  def connection
    Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end

  # Returns total hours logged across all given hackatime project names.
  def calculate_hours_needed(project_names)
    total_seconds = project_names.sum do |project_name|
      stats = fetch_stats(project_name)
      next 0 unless stats

      stats.dig("data", "total_seconds").to_f
    end

    total_seconds / 3600.0
  end

  private

  def fetch_stats(project_name)
    response = connection.get("/api/v1/users/#{@slack_id}/stats", { project: project_name })
    return nil unless response.success?

    JSON.parse(response.body)
  end
end
