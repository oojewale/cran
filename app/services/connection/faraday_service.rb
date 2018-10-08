module Connection
  class FaradayService
    def self.connect
      ::Faraday.new('https://cran.r-project.org/src/contrib/') do |conn|
        conn.request :json
        conn.response :logger, Rails.logger
        conn.adapter ::Faraday.default_adapter
      end
    end
  end
end
