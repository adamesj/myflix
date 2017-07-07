require 'rails_helper'

RSpec.describe VideosController, type: :controller do
  let!(:user) { create (:user) }

  describe "GET show as an authenticated user" do
    before :each do
      sign_in(user)
    end

    it "assigns the requested video to @video" do
      category = Category.create(name: "TV Dramas")
      video = Video.create(
        title: "Fargo",
        description: "Self-made real estate mogul Emmit Stussy seemingly has it all.",
        category_id: category.id
      )

      get :show, params: { id: video.id }
      expect(assigns(:video)).to eq video
    end

    it "renders the show page" do
      category = Category.create(name: "TV Dramas")
      video = Video.create(
        title: "Fargo",
        description: "Self-made real estate mogul Emmit Stussy seemingly has it all.",
        category_id: category.id
      )

      get :show, params: { id: video.id }
      expect(response).to render_template :show
    end
  end

  describe "GET show as an unauthenticated user" do
    it "redirects to the log in page" do
      category = Category.create(name: "TV Dramas")
      video = Video.create(
        title: "Fargo",
        description: "Self-made real estate mogul Emmit Stussy seemingly has it all.",
        category_id: category.id
      )

      get :show, params: { id: video.id }
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "GET search as an authenticated user" do
    before :each do
      sign_in(user)
    end

    it "it assigns the requested query to @results" do
      category = Category.create(name: "TV Dramas")
      video = Video.create(
        title: "Fargo",
        description: "Self-made real estate mogul Emmit Stussy seemingly has it all.",
        category_id: category.id
      )
      get :search, params: { search_term: video.title }
      expect(assigns(:results)).to eq [video]
    end

    it "renders the search page" do
      category = Category.create(name: "TV Dramas")
      video = Video.create(
        title: "Fargo",
        description: "Self-made real estate mogul Emmit Stussy seemingly has it all.",
        category_id: category.id
      )
      get :search, params: { search_term: video.title }
      expect(response).to render_template :search
    end
  end

  describe "GET search as an unauthenticated user" do
    it "redirects to the log in page" do
      category = Category.create(name: "TV Dramas")
      video = Video.create(
        title: "Fargo",
        description: "Self-made real estate mogul Emmit Stussy seemingly has it all.",
        category_id: category.id
      )

      get :search, params: { search_term: video.title }
      expect(response).to redirect_to new_user_session_path
    end
  end
end
