module Fetchers::BaseService
  extend ActiveSupport::Concern

  included do
    def conn
      @conn ||= Connection::FaradayService.connect
    end

    def header
      { "Content-Type": "application/json" }
    end
  end
end


