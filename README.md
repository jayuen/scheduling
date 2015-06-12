## Hacky way to execute algorithm (using irb)
- open irb from scheduler/lib:
 - `$ bundle exec irb`

- require the scheduler
  - `require './scheduler'

- execute algorithm
  - `Scheduler.run("../data/demands.csv", "Jun 12, 11am", 100, 5)


## Slightly less hacky way to execute algorithm using ruby interpreter
  - cd into scheduler/lib
  - bundle exec ruby example_runner.rb
