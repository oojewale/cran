class PackagesController < ApplicationController
  def index
    @packages = Package.all.limit(50)
  end
end
