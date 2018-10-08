FactoryBot.define do
  factory :package do
    sequence(:id) { |n| n }
    name { Faker::Lorem.word }
  end
end
