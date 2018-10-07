require 'dcf'
require 'zlib'
require 'rubygems/package'

class Fetchers::PackageService
  include Fetchers::BaseService
  attr_reader :package_name, :package_version

  def initialize(options = {})
    @package_name = options[:name]
    @package_version = options[:version]
  end

  def call
    begin
      # response = conn.get "abctools_1.1.3.tar.gz"

      response = conn.get "#{package_name}_#{package_version}.tar.gz"

      unless response.status == 200
        raise 'Request to get packages file was unsuccessful.' +
          "See response message here => #{response.body}"
      end

      stream = Zlib::GzipReader.new(StringIO.new(response.body))
      extract = Gem::Package::TarReader.new(stream)

      description_file = extract.detect { |entry| entry.full_name.match(/DESCRIPTION$/) }
      extract.close

      Dcf.parse(description_file.read).first if description_file
    rescue => e
      Rails.logger.error { "#{self.class.name}##{__method__} raised error: #{e.message}" }
      nil
    end
  end
end
