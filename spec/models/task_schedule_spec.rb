require 'rails_helper'

RSpec.describe TaskSchedule, type: :model do
  it('creates a task with task_schedule with default values') do
    task_schedule = ObjectCreation.create_task_schedule

    added_task = task_schedule.add_task
    expect(added_task.due_date).to eq(task_schedule.due_date)
    expect(added_task.name).to eq(task_schedule.name)
    expect(added_task.user_id).to eq(task_schedule.user_id)
    expect(added_task.completed).to be_nil
  end

  it('creates a task with completed value passed in') do
    task_schedule = ObjectCreation.create_task_schedule

    completed_task = task_schedule.add_task({completed: true})
    expect(completed_task.completed).to be true
    incomplete_task = task_schedule.add_task({completed: false})
    expect(incomplete_task.completed).to be false
  end
end
