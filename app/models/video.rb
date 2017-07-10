# == Schema Information
#
# Table name: videos
#
#  id              :integer          not null, primary key
#  title           :string
#  description     :text
#  small_cover_url :string
#  large_cover_url :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :integer
#

class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews

  validates :title, :description, presence: true
  validates :title, length: { minimum: 2 }
  # validates :title, uniqueness: true

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("lower(title) LIKE lower(?)", "%#{search_term}%").order("created_at DESC")
    # the percentage symbol surrounding the interpolated search_term
    # will return results that partially match what the user enters
  end

  def average_rating
    reviews.average(:rating).to_f
  end

  def highest_rated_review
    reviews.rating_desc.first
  end
end
