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
end
