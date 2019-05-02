FactoryBot.define do
  factory :item do
    name { "Apples" }
    description { "Red" }
    unit_price { 1 }
    merchant
  end
end
