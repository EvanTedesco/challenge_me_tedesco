class ExpireTasksJob < ApplicationJob
  queue_as :default

  def perform(expiry_date)
    Task.mark_expired(expiry_date)
  end
end
