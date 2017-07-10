require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe "POST create" do
    let!(:user) { create (:user) }
    let!(:video) { create (:video_with_category) }

    before :each do
      sign_in(user)
    end

    context "with valid inputs" do
      it "saves the new review to the database" do
        post :create, params: { review: FactoryGirl.attributes_for(:review_with_video), video_id: video.id }
        expect(Review.count).to eq 1
      end

      it "creates a review associated with the video" do
        post :create, params: { review: FactoryGirl.attributes_for(:review_with_video), video_id: video.id }
        expect(Review.first.video).to eq(video)
      end

      it "creates a review associated with the signed in user" do
        post :create, params: { review: FactoryGirl.attributes_for(:review_with_video), video_id: video.id }
        expect(Review.first.user).to eq(user)
      end

      it "redirects to video show page" do
        post :create, params: { review: FactoryGirl.attributes_for(:review_with_video), video_id: video.id }
        expect(response).to redirect_to video_path(video)
      end
    end

    context "with invalid inputs" do
      it "renders the videos/show template" do
        post :create, params: { review: FactoryGirl.attributes_for(:review, rating: nil), video_id: video.id}
        expect(Review.count).to eq 0
      end

      it "sets @video" do
        post :create, params: { review: FactoryGirl.attributes_for(:review, rating: nil), video_id: video.id}
        expect(assigns(:video)).to eq video
      end

      it "sets @reviews" do
        review = create(:review, video: video, user: user)
        post :create, params: {review: FactoryGirl.attributes_for(:review, rating: nil), video_id: video.id}
        expect(assigns(:reviews).first).to eq review
      end
    end
  end
end
