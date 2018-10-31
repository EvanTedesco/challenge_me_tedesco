class TaskSchedule < ApplicationRecord
  belongs_to :user

  def add_task(params = {})
    target_attributes  = self.attributes.slice('name', 'due_date', 'user_id')
    target_attributes[:completed] = params[:completed]
    Task.create(target_attributes)
  end
end
