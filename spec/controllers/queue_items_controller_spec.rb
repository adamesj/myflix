require 'rails_helper'

RSpec.describe QueueItemsController, type: :controller do
  let!(:user) { create (:user) }

  describe "GET index" do
    it "assigns queue items of the logged to @queue_items" do
      sign_in(user)
      queue_item1 = create(:queue_item, user: user)
      queue_item2 = create(:queue_item, user: user)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "should redirect to sign in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end
end
