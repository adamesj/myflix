FactoryGirl.define do
  factory :user do
    first_name            Faker::Name.first_name
    last_name             Faker::Name.last_name
    email                 Faker::Internet.unique.email
    password              "PASSWORD#1"
    password_confirmation "PASSWORD#1"

    factory :invalid_user do
      first_name            Faker::Name.first_name
      last_name             Faker::Name.last_name
      email                 nil
      password              "PASSWORD#1"
      password_confirmation "PASSWORD#1"
    end

    factory :user_with_review do
      after(:build) do |review|
        review = create(:review_with_video)
        user.reviews << review
      end
    end
  end
end
