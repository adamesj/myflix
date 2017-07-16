require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do
  let!(:user) { create (:user) }
  let!(:video) { create (:video_with_category) }
  let!(:queue_item1) { create :queue_item, user_id: user.id, video_id: video.id, position: 1 }
  let!(:queue_item2) { create :queue_item, user_id: user.id, video_id: video.id, position: 2 }

  describe "GET index" do
    it "assigns queue items of the logged to @queue_items" do
      sign_in(user)
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
      expect(QueueItem.count).to eq 2
    end

    it "creates a queue_item that is associated with the video" do
      sign_in(user)
      post :create, params: { video_id: video.id }
      expect(QueueItem.first.video).to eq video
    end

    it "creates a queue_item that is associated with the signed in user" do
      sign_in(user)
      post :create, params: { video_id: video.id }
      expect(QueueItem.first.user).to eq user
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

  describe "POST update_queue" do
    context "with valid inputs" do

      before do
        sign_in(user)
      end

      it "redirects to the my queue page and reorder queue items" do
        post :update_queue, params: {queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]}
        expect(response).to redirect_to my_queue_path
      end

      it "reorders the queue items" do
        post :update_queue, params: {queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]}
        expect(user.queue_items).to eq [queue_item2, queue_item1]
      end

      it "normalizes the position numbers" do
        post :update_queue, params: {queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]}
        expect(user.queue_items.map(&:position)).to eq [1,2]
      end
    end

    context "with invalid inputs" do

      before do
        sign_in(user)
      end

      it "redirects to the my queue page" do
        post :update_queue, params: {queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 1}]}
        expect(response).to redirect_to my_queue_path
      end

      it "sets the flash error message" do
        post :update_queue, params: {queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 1}]}
        expect(flash[:error]).to be_present
      end

      it "does not change the queue items" do
        post :update_queue, params: {queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]}
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    context "with unauthenticated users" do
      it "redirects to the sign in path" do
        post :update_queue, params: {queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]}
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "with queue items that do not belong to the current user" do
      it "does not change the queue items" do
        bernard = create(:user, email: "feeldbern@mail.com")
        sign_in(bernard)
        post :update_queue, params: {queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]}
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end

  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      sign_in(user)
      delete :destroy, params: {id: queue_item1.id}
      expect(response).to redirect_to my_queue_path
    end

    it "deletes the queue item" do
      sign_in(user)
      delete :destroy, params: {id: queue_item1.id}
      delete :destroy, params: {id: queue_item2.id}
      expect(QueueItem.count).to eq 0
    end

    it "normalizes the remaining queue items" do
      delete :destroy, params: {id: queue_item1.id}
      expect(QueueItem.first.position).to eq 1
    end

    it "does not delete the queue item if the queue item is not in the current user's queue" do
      bernard = create(:user, email: "feeldbern@mail.com")
      sign_in(bernard)
      delete :destroy, params: {id: queue_item1.id}
      expect(QueueItem.count).to eq 2
    end

    it "redirects to the sign in page for unauthenticated users" do
      queue_item = create(:queue_item, user: user, video: video)
      delete :destroy, params: {id: queue_item.id}
      expect(response).to redirect_to new_user_session_path
    end
  end
end
