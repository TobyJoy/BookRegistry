require 'faker'
FactoryBot.define do
  factory :book do |f|
    f.book_name { Faker::Name.name }
    f.author { Faker::Name.name }
    f.isbn { Faker::Name.name }
    f.price { Faker::Number.between(1, 10) }
    f.category { Faker::Name.name }
    f.publish_status {Faker::Boolean.boolean}
  end
end
