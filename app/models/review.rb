# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  rating     :integer
#  body       :text
#  video_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Review < ApplicationRecord
  belongs_to :video
  belongs_to :user

  scope :rating_desc, -> { order(rating: :desc) }
  # Take the current video, and select all reviews
  # associated with it. Use the order method
  # to order it by ratings in a descending way.

  validates :rating, :body, presence: true
  #validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
