require 'rails_helper'

RSpec.describe TaskSchedule, type: :model do
  context('add_task') do
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

  context('user_tasks') do
    it('gets the task for the user') do
      user = ObjectCreation.create_user
      random_user = ObjectCreation.create_user
      associated_schedule = ObjectCreation.create_task_schedule({user_id: user.id})
      random_schedule = ObjectCreation.create_task_schedule

      expected_task1 = ObjectCreation.create_task(user_id: user.id, task_schedule_id: associated_schedule.id)
      expected_task2 = ObjectCreation.create_task(user_id: user.id, task_schedule_id: associated_schedule.id)

      un_expected_task1 = ObjectCreation.create_task(user_id: random_user.id, task_schedule_id: random_schedule.id)
      un_expected_task2 = ObjectCreation.create_task(user_id: random_user.id, task_schedule_id: random_schedule.id)

      actual = associated_schedule.user_tasks
      expect(actual).to match_array([expected_task1, expected_task2])
      expect(actual).to_not match_array([un_expected_task1, un_expected_task2])
    end
  end

  context('user_task_schedules') do
    it('gets the task schedules for the user') do
      user = ObjectCreation.create_user
      random_user = ObjectCreation.create_user
      associated_schedule = ObjectCreation.create_task_schedule({user_id: user.id})
      associated_schedule2 = ObjectCreation.create_task_schedule({user_id: user.id})
      random_schedule = ObjectCreation.create_task_schedule({user_id: random_user})

      actual = associated_schedule.user_task_schedules
      expect(actual).to match_array([associated_schedule, associated_schedule2])
      expect(actual).to_not match_array([random_schedule])
    end
  end

  context('task_completed?') do
    it('tells if the child task is complete') do
      incomplete_schedule = ObjectCreation.create_task_schedule
      incomplete_schedule.add_task({completed: false})
      complete_schedule = ObjectCreation.create_task_schedule
      complete_schedule.add_task({completed: true})
      nil_schedule = ObjectCreation.create_task_schedule
      nil_schedule.add_task({completed: nil})

      expect(complete_schedule.task_completed?).to eq(true)
      expect(incomplete_schedule.task_completed?).to eq(false)
      expect(nil_schedule.task_completed?).to eq(false)
    end
  end
end
