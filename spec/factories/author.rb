FactoryBot.define do
  factory :author do
    sequence(:id) { |n| n }
    name { Faker::Lorem.word }
  end
end
