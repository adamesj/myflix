class Video < ActiveRecord::Base
  belongs_to :category
  validates :title, :description, presence: true
  validates :title, length: { minimum: 2 }
  validates :title, uniqueness: true
end
