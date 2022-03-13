FactoryBot.define do
  factory :item do
    name { Faker::App.name }
    content { Faker::Lorem.paragraphs(number: 1) }
    category_id { Faker::Number.between(from: 1, to: 10) }
    condition_id { Faker::Number.between(from: 1, to: 6) }
    charge_id { Faker::Number.between(from: 1, to: 2) }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    shipping_id { Faker::Number.between(from: 1, to: 3) }
    price { Faker::Number.within(range: 300..10_000_000) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
