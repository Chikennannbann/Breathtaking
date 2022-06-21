FactoryBot.define do
  factory :end_user do
    name { Faker::Lorem.characters(number:5) }
    email { Faker::Internet.email }
    encrypted_password { 'password' }
  end
end