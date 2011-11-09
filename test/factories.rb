require 'faker'

FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password "asphincterintimeendershadow"
    password_confirmation "asphincterintimeendershadow"
    email { "#{username}@example.com" }
  end

  factory :card do
    title { Faker::Company.bs }
    body { Faker::Lorem.paragraphs.join("\n\n") }
    perms "all"
    user
  end

  factory :group do
    name { Faker::Company.name }
    user
  end
end

