FactoryBot.define do
  factory :merchant do
    name { "Jim Bob"}
    created_at { DateTime.now.strftime('%Y-%m-%d %H:%M:%S') } 
  end
end
