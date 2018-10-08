require 'dcf'

class Fetchers::PackagesService
  include Fetchers::BaseService

  def call
    begin
      response = conn.get "PACKAGES"

      unless response.status == 200
        raise 'Request to get packages file was unsuccessful.' +
          "See response message here => #{response.body}"
      end
      Dcf.parse(response.body)
    rescue => e
      Rails.logger.error { "#{self.class.name}##{__method__} raised error: #{e.message}" }
      nil
    end
  end
end
