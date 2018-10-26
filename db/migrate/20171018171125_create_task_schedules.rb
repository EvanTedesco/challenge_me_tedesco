class CreateTaskSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :task_schedules do |t|
      t.string :name
      t.datetime :due_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
