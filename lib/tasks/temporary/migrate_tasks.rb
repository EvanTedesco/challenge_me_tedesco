namespace :users do
  desc "Update tasks to new schema"
  task update_tasks: :environment do

    ActiveRecord::Base.transaction do
    #   TODO migrate tasks
    end

    puts "Job's finished"
  end
end