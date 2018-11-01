require 'rails_helper'

RSpec.describe Task, type: :model do
  context('mark_expired') do
    it('marks tasks as expired ') do
      expired_task = ObjectCreation.create_task
      expired_task2 = ObjectCreation.create_task
      future_task = ObjectCreation.create_task
      Task.mark_expired([expired_task, expired_task2])
      expect(expired_task.reload.completed).to be(false)
      expect(expired_task2.reload.completed).to be(false)
      expect(future_task.reload.completed).to be(nil)
    end

    it('handles empty task array') do
      expect {Task.mark_expired}.to_not raise_error(NoMethodError)
    end
  end

  context('expire tasks') do
    it('calls ExpireTasksJob') do
      t = Time.now
      expired_task = ObjectCreation.create_task(due_date: 9.days.ago)
      expired_task2 = ObjectCreation.create_task(due_date: t)
      ExpireTasksJob.any_instance.stub(:perform).and_return(Task.mark_expired([expired_task, expired_task2]))
      future_task = ObjectCreation.create_task(due_date: t + 9.days)

      expect(expired_task.completed).to eq(false)
      expect(expired_task2.completed).to eq(false)
      expect(future_task.completed).to eq(nil)
    end
  end
end