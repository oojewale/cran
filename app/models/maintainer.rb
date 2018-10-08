# == Schema Information
#
# Table name: maintainers
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Maintainer < ApplicationRecord
  has_and_belongs_to_many :packages

  validates :email, presence: true, uniqueness: true
end
