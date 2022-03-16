FactoryBot.define do
  factory :order_address do
    post_code { "#{Faker::Number.decimal_part(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.non_zero_digit }
    city { Faker::Address.city }
    address1 { Faker::Address.street_address }
    build_addr { Faker::Address.street_address }
    phone { Faker::Number.decimal_part(digits: 10) }
    token { Faker::Internet.password(special_characters: true) }
  end
end
