FactoryBot.define do
  factory :favorite do
    # post_id {1}
    
   association :end_user
   association :post
  end
end