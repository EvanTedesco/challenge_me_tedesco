class Task < ApplicationRecord
  belongs_to :user
  belongs_to :task_schedule

  def self.mark_expired(expiry_date = Time.now)
    Task.where("due_date <= ?", expiry_date).find_in_batches do | tasks |
        tasks.each do |task|
          begin
          task.update_attributes!(completed: false)
          rescue => e
            puts "Task: #{task.id} failed to be marked as expired due to: #{e.message} #{e.backtrace}"
          end
        end
    end
  end
end
