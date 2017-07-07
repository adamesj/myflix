class Category < ActiveRecord::Base
  has_many :videos
  # because of the has_many association, we can call videos in the category model
  validates :name, presence: true

  def recent_videos
    if videos.length >= 6
      videos.limit(6).order("created_at DESC")
    else
      videos.all
    # returns the six last videos
    # if there is less than six, return all
    # if there is more than six, return six
    end
  end
end
