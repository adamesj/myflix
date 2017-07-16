class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :position, numericality: {only_integer: true}

  delegate :category, to: :video
  # queue_item.video.category
  delegate :title, to: :video, prefix: :video
  # queue_item.video_title

  # def video_title
  #   video.title
  # end

  def rating
    review.rating if review
  end

  # this method will have rating act as a virtual attribute for the queue item model
  def rating=(new_rating)
    if review # is present
      review.update_column(:rating, new_rating)
    else
      review = Review.new(user: user, video: video, rating: new_rating)
      # because we are validating that a review has content
      # we cannot use create
      review.save(validate: false)
    end
    # update column bypasses record validations
  end

  def category_name
    #video.
    category.name
  end

  private
    def review
      @review ||= Review.where(user_id: user.id, video_id: video.id).first
      # @review = @review || Review.where(user_id: user.id, video_id: video.id).first
      # the first time this method is called, it will retrieve the object from the db
      # and set it to an instance variable of this class
    end

  # def category
  #   video.category
  # end
end