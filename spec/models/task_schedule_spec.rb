require 'rails_helper'

RSpec.describe TaskSchedule, type: :model do
  it('creates a task with task_schedule with default values') do
    task_schedule = ObjectCreation.create_task_schedule
    added_task = task_schedule.add_task
    target_attributes = task_schedule.attributes.slice('name', 'user_id', 'completed')

    expect(added_task).to have_attributes(target_attributes)
  end

  it('creates a task with completed value passed in') do
    task_schedule = ObjectCreation.create_task_schedule
    completed_task = task_schedule.add_task({completed: true})
    incomplete_task = task_schedule.add_task({completed: false})

    expect(completed_task.completed).to be true
    expect(incomplete_task.completed).to be false
  end

  it('creates a task with the proper due date') do
    task_schedule = ObjectCreation.create_task_schedule
    added_task = task_schedule.add_task
    schedule_due_date = task_schedule.due_date
    task_due_date = added_task.due_date

    expect(task_due_date).to eq(schedule_due_date.end_of_day)
  end

  it('creates a task with the proper associations') do
    task_schedule = ObjectCreation.create_task_schedule
    added_task = task_schedule.add_task

    expect(task_schedule.task).to eq(added_task)
    expect(added_task.task_schedule).to eq(task_schedule)
  end
end
