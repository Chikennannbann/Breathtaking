FactoryBot.define do
  factory :favorite do
   association :end_user
   association :post
  end
end