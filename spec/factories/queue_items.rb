FactoryGirl.define do
  factory :queue_item do
    position { [1,2,3].sample }
    user
    video

  end
end