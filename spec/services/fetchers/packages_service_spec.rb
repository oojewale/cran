require 'rails_helper'

RSpec.describe Fetchers::PackagesService, vcr: true do

  describe "call" do
    it "returns an Array" do
      expect(Fetchers::PackagesService.new.call).to be_an Array
    end
  end
end
