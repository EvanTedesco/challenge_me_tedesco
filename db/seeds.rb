# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


20.times do
  user = User.create(name: Faker::Name.name, email: Faker::Internet.email)
  10.times do
    due_date = (rand(9)+1).days.from_now
    TaskSchedule.create(name: Faker::Lorem.sentence, due_date: due_date, user: user)
  end
end
