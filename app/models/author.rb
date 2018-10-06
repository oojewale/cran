class Author < ApplicationRecord
  has_many :packages, as: :contributable
end
