FactoryGirl.define do
  factory :review do
    rating   4
    body     Faker::Lorem.paragraph
    user     {[FactoryGirl.create(:user)]}
    video    {[FactoryGirl.create(:video)]}
  end
end