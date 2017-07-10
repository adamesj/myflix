FactoryGirl.define do
  factory :review do
    rating   4
    body     Faker::Lorem.paragraph

    factory :review_with_video do
      after(:build) do |review|
        video = create(:video_with_category)
        video.reviews << review
      end
    end
  end
end