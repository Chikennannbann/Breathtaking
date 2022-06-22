FactoryBot.define do
  factory :end_user do
    name { Faker::Lorem.characters(number:5) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end