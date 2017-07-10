class ReviewsController < ApplicationController
  before_action :set_video
  before_action :authenticate_user!

  def create
    review = @video.reviews.build(review_params.merge!(user: current_user))
    if review.save
      redirect_to video_path(@video)
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private
    def set_video
      @video = Video.find(params[:video_id])
    end

    def review_params
      params.require(:review).permit(:rating, :body, :video_id, :user_id)
    end
end
