class Task < ApplicationRecord
  belongs_to :user
  belongs_to :task_schedule

  def self.expire_tasks(expiry_date = Time.now)
    Task.where("due_date <= ?", expiry_date).find_in_batches do |tasks|
       ExpireTasksJob.perform_later(tasks)
    end
  end

  def self.mark_expired(tasks = [])
    tasks.each{|task| task.update_attributes(completed: false)} if tasks.present?
  end
end
