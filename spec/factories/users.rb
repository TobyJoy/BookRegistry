require 'faker'

FactoryBot.define do
  factory :user do |f|
    f.email { Faker::Internet.safe_email }
    f.password { Faker::Internet.password(8) }
  end
end