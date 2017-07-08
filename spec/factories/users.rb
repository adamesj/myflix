FactoryGirl.define do
  factory :user do
    first_name            Faker::Name.first_name
    last_name             Faker::Name.last_name
    email                 Faker::Internet.unique.email
    password              "PASSWORD#1"
    password_confirmation "PASSWORD#1"
  end
end
