FactoryBot.define do
  factory :item do
    item_name           { Faker::Name.initials(number: 4) }
    description         { Faker::Lorem.paragraph }
    category_id         { Faker::Number.between(from: 1, to: 10) }
    condition_id        { Faker::Number.between(from: 1, to: 6) }
    delivery_charge_id  { Faker::Number.between(from: 1, to: 2) }
    prefecture_id       { Faker::Number.between(from: 1, to: 47) }
    day_to_send_id      { Faker::Number.between(from: 1, to: 3) }
    price               { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
