json.extract! task_schedule, :id, :name, :due_date, :user_id, :created_at, :updated_at
json.url task_schedule_url(task_schedule, format: :json)
