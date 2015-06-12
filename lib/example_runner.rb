# execute from scheduling/lib
# excute with bundle exec
# $ bundle exec ruby example_runner.rb


require './scheduler'

Scheduler.run("../data/demands.csv", "Jun 12, 11am", 100, 5)