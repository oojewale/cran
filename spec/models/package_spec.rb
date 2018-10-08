require 'rails_helper'

RSpec.describe Package, type: :model do
  before do
    create(:package, { name: "test_package", version: "1.1.1" })
  end

  describe "#name_version_exists?" do
    let(:dupe_package) do
      build(:package, { name: "test_package", version: "1.1.1" })
    end

    let(:another_package) { build(:package) }

    it "returns true for duplicate" do
      expect(dupe_package.name_version_exists?).to be true
    end

    it "returns false for non-existing record" do
      expect(another_package.name_version_exists?).to be false
    end
  end

  describe "#ensure_no_duplicate" do
    let(:dupe_package) do
      build(:package, { name: "test_package", version: "1.1.1" })
    end

    it "raises error on dupes creation" do
      msg = 'Cannot save same version of the same package twice!'
      dupe_package.save
      expect(dupe_package.errors.messages[:base]).to include(msg)
    end
  end
end
