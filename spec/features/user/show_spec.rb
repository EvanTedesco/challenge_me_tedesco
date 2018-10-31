require 'rails_helper'

def schedules_table
  '.tasksSchedulesTable'
end

def tasks_table
  '.tasksTable'
end

Capybara.add_selector(:schedule_id) do
  css { |v| "*[data-schedule-id='#{v}']" }
end

def find_schedule_by_id(value)
  find(:schedule_id, value.to_s)
end


describe :user_path do
  before(:each) do

    @user = ObjectCreation.create_user
    2.times do
      ObjectCreation.create_task_schedule({user_id: @user.id})
    end
    @user_task_schedules =  @user.task_schedules
    @task = ObjectCreation.create_task({user_id: @user.id})
    visit user_path(@user)
  end

  it 'renders user information' do
    puts'*********************************************************************'

    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.email)
  end

  it 'renders task schedules with due_date and name belonging to the user' do
    unexpected_schedule = [ObjectCreation.create_task_schedule]
    unexpected_items = unexpected_schedule.pluck(:name, :email)
    expected_items = @user_task_schedules.pluck(:name, :due_date).flatten

    expect(page).to have_content('Task Schedules')
    within(schedules_table) do
      expected_items.each{|value| expect(page).to have_content(value)}
      unexpected_items.each{|value| expect(page).to_not have_content(value)}
    end
  end

  it 'renders completed tasks' do
    within(tasks_table) do
      expect(page).to have_content(@task.name)
      expect(page).to have_content(@task.due_date)
      expect(page).to have_content(@task.completed)
    end
  end
  #
  # it 'completes a task' do
  #   within(schedules_table) do
  #     target_task = find_schedule_by_id(@user_task_schedules.first.id)
  #     within(target_task) do
  #       page.click_button('Complete Task')
  #     end
  #   end
  #   table = page.find(tasks_table)
  #   within(table) do
  #     expected = @user_task_schedules[0].pluck(:name, :email)
  #     expect(page).to have_content(expected[0])
  #   end
  # end
end