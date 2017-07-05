class AddCategoryToVideos < ActiveRecord::Migration[5.1]
  def change
    add_reference :videos, :category, index: true
  end
end
