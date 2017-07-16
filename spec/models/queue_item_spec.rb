require 'rails_helper'

RSpec.describe QueueItem, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer }

  describe "#video_title" do
    it "returns the title of the associated video" do
      user = create(:user)
      video = create(:video_with_category, title: "Bones")
      queue_item = create(:queue_item, video: video, user: user)
      expect(queue_item.video_title).to eq "Bones"
    end
  end

  describe "#rating" do
    it "returns the rating of the associated video" do
      user = create(:user)
      video = create(:video_with_category)
      review = create(:review, user: user, video: video)
      queue_item = create(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq 4
    end

    it "returns nil when the review is not present" do
      user = create(:user)
      video = create(:video_with_category, title: "Bones")
      queue_item = create(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq nil
    end
  end

  describe "#rating=" do
    it "changes the rating of the review if the rating is present" do
      user = create(:user)
      video = create(:video_with_category)
      review = create(:review, user: user, video: video, rating: 1)
      queue_item = create(:queue_item, video: video, user: user)
      queue_item.rating = 5
      expect(Review.first.rating).to eq 5
    end

    it "clears the rating of the review if the review is present" do
      user = create(:user)
      video = create(:video_with_category)
      review = create(:review, user: user, video: video, rating: 1)
      queue_item = create(:queue_item, video: video, user: user)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end

    it "creates a review with the rating if the review if not present" do
      user = create(:user)
      video = create(:video_with_category)
      queue_item = create(:queue_item, video: video, user: user)
      queue_item.rating = 4
      expect(Review.first.rating).to eq 4
    end
  end

  describe "#category_name" do
    it "returns the category's name of the associated video" do
      user = create(:user)
      video = create(:video_with_category)
      review = create(:review, user: user, video: video)
      queue_item = create(:queue_item, video: video, user: user)
      expect(queue_item.category_name).to eq "Dramas"
    end
  end

  describe "#category" do
    it "returns the category of the associated video" do
      user = create(:user)
      category = create(:category)
      video = create(:video, category: category)
      review = create(:review, user: user, video: video)
      queue_item = create(:queue_item, video: video, user: user)
      expect(queue_item.category).to eq category
    end
  end
end