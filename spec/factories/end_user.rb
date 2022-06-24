FactoryBot.define do
  factory :end_user do
    name { 'テストユーザー' }
    email { 'test@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end