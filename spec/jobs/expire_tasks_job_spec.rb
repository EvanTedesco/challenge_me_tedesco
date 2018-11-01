

RSpec.describe ExpireTasksJob do
  include ActiveJob::TestHelper

  it do
    t = Time.now
    expired_task = ObjectCreation.create_task(due_date: 9.days.ago)
    expired_task2 = ObjectCreation.create_task(due_date: t)
    perform_enqueued_jobs do
      ExpireTasksJob.perform_now([expired_task, expired_task2])
    end

    expect(expired_task.completed).to eq(false)
    expect(expired_task2.completed).to eq(false)
  end
end