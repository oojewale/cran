class Package < ApplicationRecord
  belongs_to :contributable, polymorphic: true
end
