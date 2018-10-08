class Fetchers::PackageIndexerService
  include Fetchers::BaseService
  attr_accessor :maintainers, :authors
  START_INDEX = 0
  STOP_INDEX = 50

  def initialize
    @maintainers = []
    @authors = []
  end

  def call
    packages.each do |package|
      options = {
        name: package["Package"],
        version: package["Version"]
      }

      @package_service = Fetchers::PackageService.new(options)
      package = @package_service.call
      create_package(package) if package
    end
  end

  private

  def packages
    packages = Fetchers::PackagesService.new.call
    packages[START_INDEX...STOP_INDEX] if packages
  end

  def create_package(pkg)
    @package = Package.new(package_attrs(pkg))

    return if @package.name_version_exists?

    begin
      extract_maintainers(pkg["Maintainer"])
      if pkg["Authors@R"].present?
        extract_authors(pkg["Authors@R"], true)
      elsif pkg["Author"].present?
        extract_authors(pkg["Author"])
      end

      @package.authors = authors
      @package.maintainers = maintainers
      @package.save
    rescue => e
      Rails.logger.error { "#{self.class.name}##{__method__} raised error: #{e.message}" }
    end
  end

  def package_attrs(package)
    {
      name: package['Package'],
      version: package['Version'],
      publication_date: package['Date'],
      title: package['Title'],
      description: package['Description']
    }
  end

  def extract_authors(pkg_authors, email_included = false)
    if email_included
      pkg_authors = pkg_authors.gsub('"','').gsub("\t",'').split('person')
    else
      pkg_authors = pkg_authors.gsub(/(\[\w+,*\s*\w+\])/, '').split(',')
    end

    pkg_authors.each do |author|
      name = author_name(author, email_included)
      email = author_email(author)
      get_or_create_author({ name: name, email: email }) if name
    end
  end

  def author_name(str, email_included = false)
    return str.strip unless email_included
    matches = str.match(/\((\w+,\s*\w+)/)
    matches[1].gsub(',', '').strip if matches
  end

  def author_email(str)
    matches = str.match(/(?=)email\s*=\s*([\w.@]+)/)
    matches[1] if matches
  end

  def get_or_create_author(options = {})
    author = Author.find_or_create_by(name: options[:name]) do |author|
      author.email = options[:email]
    end
    authors << author
  end

  def extract_maintainers(pkg_maintainers)
    pkg_maintainers.split(',').each do |maintainer|
      info = maintainer.match(/([\w\s]+)<([\w\W]+)>/)
      get_or_create_maintainer({ name: info[1].strip, email: info[2] }) if info
    end
  end

  def get_or_create_maintainer(options = {})
    maintainer = Maintainer.find_or_create_by(email: options[:email]) do |maintainer|
      maintainer.name = options[:name]
    end
    maintainers << maintainer
  end
end
