require 'rails_helper'

RSpec.describe Fetchers::PackageService, vcr: true do
  let(:options) do
    {
      name: 'A3',
      version: '1.0.0'
    }
  end

  describe "call" do
    it "returns a Hash" do
      expect(Fetchers::PackageService.new(options).call).to be_a Hash
    end
  end
end
