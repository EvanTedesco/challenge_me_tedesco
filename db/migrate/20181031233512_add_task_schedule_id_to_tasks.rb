class AddTaskScheduleIdToTasks < ActiveRecord::Migration[5.1]
  def change
      add_reference :tasks, :task_schedule, index: true
      add_foreign_key :tasks, :task_schedules
  end
end
