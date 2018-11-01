require 'rails_helper'

def schedules_table
  '#tasksSchedulesTable'
end

def tasks_table
  '#tasksTable'
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
    @completed_task = @user_task_schedules.first.add_task({completed: true})

    visit user_path(@user)
  end

  it 'renders user information' do
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
      expect(page).to have_content(@completed_task.name)
      expect(page).to have_content(@completed_task.due_date)
      expect(page).to have_content(@completed_task.completed)
    end
  end

  it 'completes a task', js: true do
    schedule = @user_task_schedules.second
    expected = schedule.slice(:name, :due_date)[0]
    within(schedules_table) do
      target_schedule = find_schedule_by_id(schedule.id)
      within(target_schedule) do
        page.click_button('Complete Task')
      end
      disabled_schedule = find_schedule_by_id(schedule.id)
      within(disabled_schedule) do
        button = page.find('button > input[type="submit"]')
        expect(button.disabled?).to be(true)
      end
    end
    table = page.find(tasks_table)
    within(table) do
      expect(page).to have_content(expected)
    end
  end
end