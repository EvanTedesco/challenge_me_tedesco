class TaskSchedule < ApplicationRecord
  belongs_to :user
  has_one :task

  def add_task(params = {})
    target_attributes = self.attributes.slice('name', 'user_id')
    variables = {
      completed: params[:completed],
      task_schedule_id: self.id,
      due_date: self.due_date.end_of_day,
    }
    task_fields = variables.merge(target_attributes)
    Task.create(task_fields)
  end

  def task_completed?
    self.task.present? && self.task.completed.present?
  end

  def user_tasks
    self.user.tasks
  end

  def user_task_schedules
    self.user.task_schedules
  end
end
