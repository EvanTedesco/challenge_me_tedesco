class ExpireTasksJob < ApplicationJob
  queue_as :default
  rescue_from ActiveJob::DeserializationError do |e|
      puts "Failed to update task due to #{e}  at #{e.backtrace}"
  end

  def perform(tasks)
    Task.mark_expired(tasks)
  end
end
