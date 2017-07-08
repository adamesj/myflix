FactoryGirl.define do
  factory :video do
    title             Faker::Book.title
    description       Faker::Lorem.paragraph
    small_cover_url   Faker::Internet.url
    large_cover_url   Faker::Internet.url

    factory :video_with_category do
      after(:build) do |video|
        category = create(:category)
        # before persisting to the database,
        # create a category then save it to category videos
        # in an after build callback
        category.videos << video
      end
    end
  end
end