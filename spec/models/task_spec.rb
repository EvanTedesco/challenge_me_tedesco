require 'rails_helper'

RSpec.describe Task, type: :model do
  context('mark_expired') do
    it('marks expired tasks as expired ') do
      t = Time.now
      expired_task = ObjectCreation.create_task({due_date: t - 1.day})
      expiring_task = ObjectCreation.create_task({due_date: t})
      future_task = ObjectCreation.create_task({due_date: t + 1.day})
      expect(expired_task.completed).to be_nil
      expect(expiring_task.completed).to be_nil
      expect(future_task.completed).to be_nil
      Task.mark_expired(t)
      expect(expired_task.reload.completed).to be(false)
      expect(expiring_task.reload.completed).to be(false)
      expect(future_task.reload.completed).to be(nil)
    end

    it('defaults to current time if no expiry given ') do
      t = Time.now
      expired_task = ObjectCreation.create_task({due_date: t - 1.day})
      future_task = ObjectCreation.create_task({due_date: t + 1.day})
      expect(expired_task.completed).to be_nil
      expect(future_task.completed).to be_nil
      Task.mark_expired
      expect(expired_task.reload.completed).to be(false)
      expect(future_task.reload.completed).to be(nil)
    end
  end
end
