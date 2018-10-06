class Maintainer < ApplicationRecord
  has_many :packages, as: :contributable
end
