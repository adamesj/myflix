class CreateQueueItems < ActiveRecord::Migration[5.1]
  def change
    create_table :queue_items do |t|
      t.references :video, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
