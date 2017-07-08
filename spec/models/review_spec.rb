require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:user) { create (:user) }
  let!(:video) { create (:video_with_category) }

  before :each do
    login_as(user)
  end

  it "saves itself" do
    review = Review.new(
      rating: 3,
      body: "This movie was pretty rad!"
    )
    review.save
    expect(review.rating).to eq 3
  end

  it "is valid with a rating and body" do
    review = Review.new(
      rating: 3,
      body: "This movie was pretty rad!",
      user_id: user.id,
      video_id: video.id
    )
    expect(review).to be_valid
  end

  it "is invalid without a rating" do
    review = Review.new(
      rating: nil,
      body: "This movie was pretty rad!",
      user_id: user.id,
      video_id: video.id
    )
    review.valid?
    expect(review.errors[:rating]).to include("can't be blank")
  end

  it "is invalid without a numerical rating" do
    review = Review.new(
      rating: "one",
      body: "This movie was pretty rad!",
      user_id: user.id,
      video_id: video.id
    )
    review.valid?
    expect(review.errors[:rating]).to include("is not a number")
  end

  it "is invalid if the numerical rating is greater than 5" do
    review = Review.new(
      rating: 6,
      body: "This movie was pretty rad!",
      user_id: user.id,
      video_id: video.id
    )
    review.valid?
    expect(review.errors[:rating]).to include("must be less than or equal to 5")
  end

  it "is invalid if the numerical rating is less than 0" do
    review = Review.new(
      rating: -1,
      body: "This movie was pretty rad!",
      user_id: user.id,
      video_id: video.id
    )
    review.valid?
    expect(review.errors[:rating]).to include("must be greater than or equal to 0")
  end
end
