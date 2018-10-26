require 'rails_helper'

RSpec.describe Package, type: :model do
  before do
    create(:package, { name: "test_package", version: "1.1.1" })
  end

  describe "#ensure_no_duplicate" do
    let(:dupe_package) do
      build(:package, { name: "test_package", version: "1.1.1" })
    end

    it "raises error on dupes creation" do
      msg = 'Cannot save same version of the same package twice!'
      dupe_package.save
      expect(dupe_package.errors.messages[:version]).to include(msg)
    end
  end
end
