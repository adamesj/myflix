# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :videos, -> { order(:created_at) } # created_at DESC
  # because of the has_many association, we can call videos in the category model
  validates :name, presence: true

  def recent_videos
    if videos.length >= 6
      videos.first(6)
      # returns the first six videos that were most recently created
    else
      videos.all
    # returns the six last videos
    # if there is less than six, return all
    # if there is more than six, return six
    end
  end
end
