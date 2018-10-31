module ObjectCreation
  class << self
    def create_user(attrs = {})
      defaults = {
        name: Faker::Name.name,
        email: Faker::Internet.email
      }
      defaults.merge!(attrs)
      User.create(defaults)
    end

    def create_task_schedule(attrs = {})
      defaults = {
        due_date: (rand(9)+1).days.from_now,
        name: Faker::Lorem.sentence,
      }
      defaults.merge!(attrs)
      user_id = defaults.has_key?(:user_id) ? defaults[:user_id] : create_user.id
      defaults[:user_id] = user_id
      TaskSchedule.create(defaults)
    end

    def create_task(attrs = {})
      defaults = {
        due_date: (rand(9)+1).days.from_now,
        name: Faker::Lorem.sentence,
        completed: false,
      }
      defaults.merge!(attrs)
      user_id = defaults.has_key?(:user_id) ? defaults[:user_id] : create_user.id
      defaults[:user_id] = user_id
      Task.create(defaults)
    end
  end
end