require 'ai4r'
require './scheduling_chromosome'
require './scheduling_data'
require './demand'

puts "Initializing" 
SchedulingData.load_demand('demands.csv')
SchedulingData.start_date = Time.parse('2015-05-01')
puts "Demand"
p SchedulingData.demands

puts "Beginning genetic search, please wait... "
initial_population_size = 500 # 800
generations = 100 #1000


search = Ai4r::GeneticAlgorithm::GeneticSearch.new(initial_population_size, generations, SchedulingChromosome)
result = search.run
puts "FINAL CHROMOSOME"
p result.display
