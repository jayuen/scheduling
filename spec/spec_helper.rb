require './lib/scheduling_chromosome'
require './lib/demand'
require './lib/scheduling_data'
require './lib/genetic_algorithm'


RSpec.configure do |c|
  c.filter_run_including focus: true
  c.run_all_when_everything_filtered = true
end