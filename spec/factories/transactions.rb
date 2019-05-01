FactoryBot.define do
  factory :transaction do
    credit_card_number { "1111222233334444" }
    credit_card_expiration_date { "01012022" }
    result { 1 }
  end
end
 