# README

This is a simple Rails app designed to challenge you and demonstrate your Rails skills.
The challenges here can take as much or as little time as you put into them.  They are designed
to take no more than a couple of hours but depending on your skill level and obsession
with perfection you may spend more time if you want.

To start:

* Fork this repository
* Clone your forked repo to your local machine
* Install the bundle: `bundle install`
* Prepare the db: `rake db:create; rake db:migrate; rake db:seed`
* Make sure tests are passing

```bash
$ rspec spec
.******...

10 examples, 0 failures, 6 pending
```

## Overview

Challenge Me is a simple "todo" application.  The main model is User.  Users have
many task schedules.  These tasks have a simple "Due Date" that says when the task
should be completed.  When a task is completed, an Task object for the user should be
completed and would be displayed on the user's Show page.

Currently, the app is pretty useless. You need to make function.  If you click on
"Show" for a user, you will see a user's completed tasks and their task schedule.

The below challenges are simple but are meant to help us understand how you address
problems with Ruby on Rails.  We are NOT looking for front end design, layout magic,
these tests are all related to models and controllers and associated backend functionality.
You should only be concerned about the most basic View functionality.


## Challenge 1

Right now, the app is incredibly useless.  To make it somewhat useful, please
add a "Complete" button next to the task_schedule on the user's Show page
so that when a user complete's an assigned task, it is recorded.  The completed
task should now also be displayed on the show page.

Bonus points: Use AJAX

## Challenge 2

The app currently does not record tasks as incomplete, it only records those tasks
we marked as complete in the previous challenge.  We need a background job processor
that can create the incomplete tasks if the due date has expired.

Bonus points: Use the modern ActiveJob syntax so that any processor would work (Delayed Job, Sidekick, Resque, etc)

## Challenge 3

The app currently does not display or respect Time Zones.  Add functionality to allow
a user to select their local time zone and have tasks/schedules displayed in their local
time zone.

Bonus points: add a "today" view that shows todays tasks (both schedule and completed) as a single view.

# FAQ

1. Do I need to write tests?
  * Do you write tests in your normal programming flow?  If yes, its probably a good idea.
1. Is there specific objective answers you are looking for?
  * No, there are probably 100 ways to address each challenge, we are looking to understand your basic approach to coding.
1. Should I spend more than 2 hours on this:
  * No, just get done what you can. We'd love to see you address all 3 challenges but recognize that your time is important too.
