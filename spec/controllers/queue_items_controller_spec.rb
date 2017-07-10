require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do
  let!(:user) { create (:user) }
  let!(:video) { create (:video_with_category) }

  describe "GET index" do
    it "assigns queue items of the logged to @queue_items" do
      sign_in(user)
      queue_item1 = create(:queue_item, user: user, video: video)
      queue_item2 = create(:queue_item, user: user, video: video)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "should redirect to sign in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "POST create" do
    it "should redirect to the my queue path" do
      sign_in(user)
      post :create, params: { video_id: video.id }
      expect(response).to redirect_to my_queue_path
    end

    it "should add a new queue to the database" do
      sign_in(user)
      post :create, params: { video_id: video.id }
      expect(QueueItem.count).to eq 1
    end

    it "creates a queue_item that is associated with the video" do
      sign_in(user)
      post :create, params: { video_id: video.id }
      expect(QueueItem.first.video).to eq video
    end

    it "creates a queue_item that is associated with the signed in user" do
      bernard = create(:user, email: "feeldbern@mail.com")
      sign_in(bernard)
      post :create, params: { video_id: video.id }
      expect(QueueItem.first.user).to eq bernard
    end

    it "puts the video as the last one in the queue" do
      bernard = create(:user, email: "feeldbern@mail.com")
      sign_in(bernard)
      movie1 = create(:video_with_category)
      create(:queue_item, video: movie1, user: bernard)
      movie2 = create(:video_with_category)
      post :create, params: { video_id: movie2.id}
      movie2_queue_item = QueueItem.where(video_id: movie2.id, user_id: bernard.id).first
      expect(movie2_queue_item.position).to eq 2
    end

    it "does not add the video to the queue if the video is already in the queue" do
      bernard = create(:user, email: "feeldbern@mail.com")
      sign_in(bernard)
      movie = create(:video_with_category)
      create(:queue_item, video: movie, user: bernard)
      post :create, params: { video_id: movie.id}
      expect(bernard.queue_items.count).to eq 1
    end

    it "redirects to the sign in page for unauthenticated users" do
      post :create, params: {video_id: 2}
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      sign_in(user)
      queue_item = create(:queue_item, user: user, video: video)
      delete :destroy, params: {id: queue_item.id}
      expect(response).to redirect_to my_queue_path
    end

    it "deletes the queue item" do
      sign_in(user)
      queue_item = create(:queue_item, user: user, video: video)
      delete :destroy, params: {id: queue_item.id}
      expect(QueueItem.count).to eq 0
    end

    it "does not delete the queue item if the queue item is not in the current user's queue" do
      bernard = create(:user, email: "feeldbern@mail.com")
      sign_in(bernard)
      queue_item = create(:queue_item, user: user, video: video)
      delete :destroy, params: {id: queue_item.id}
      expect(QueueItem.count).to eq 1
    end

    it "redirects to the sign in page for unauthenticated users" do
      queue_item = create(:queue_item, user: user, video: video)
      delete :destroy, params: {id: queue_item.id}
      expect(response).to redirect_to new_user_session_path
    end
  end
end
