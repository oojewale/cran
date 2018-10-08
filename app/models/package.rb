# == Schema Information
#
# Table name: packages
#
#  id               :bigint(8)        not null, primary key
#  name             :string
#  version          :string
#  publication_date :date
#  title            :string
#  description      :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Package < ApplicationRecord
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :maintainers

  before_create :ensure_no_duplicate

  def name_version_exists?
    Package.exists?({ name: self.name, version: self.version })
  end

  def ensure_no_duplicate
    if name_version_exists?
      halt(msg: 'Cannot save same version of the same package twice!')
    end
  end
end
