FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:30) }
    nation { Faker::Lorem.characters(number:5) }
    prefecture { Faker::Lorem.characters(number:5) }
    place { Faker::Lorem.characters(number:10) }
  end
end