FactoryBot.define do
  factory :maintainer do
    sequence(:id) { |n| n }
    email { Faker::Internet.email }
  end
end
