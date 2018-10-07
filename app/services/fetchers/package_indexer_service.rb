class Fetchers::PackageIndexerService
  include Fetchers::BaseService

  def call
    packages = Fetchers::PackagesService.new.call
  end

  private

  def packages
    packages = Fetchers::PackagesService.new.call
    packages[0...50] if packages
  end

  def package_description
    packages.each do |package|
      options = {
        name: package["Package"]
        version: package["Version"]
      }

      package = Fetchers::PackageService.new.call
      create_package(package) if package
    end
  end

  def create_package

  end

  def authors

  end

  def maintainers
    details = []
    maintainers.split(',').each do |maintainer|
      info = maintainer.match(/([\w\s]+)<([\w\W]+)>/)
      if info
        details << { name: info[0].strip, emails: info[1] }
      end
    end
    details
  end

  def create_main
end
