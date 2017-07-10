class QueueItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @queue_items = current_user.queue_items
  end
end
