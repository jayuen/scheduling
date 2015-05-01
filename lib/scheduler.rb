require 'ai4r'
require './scheduling_chromosome'
require './scheduling_data'
require './demand'

class Scheduler
  def self.score(filename, start_date)
    SchedulingData.load_demand(filename)
    SchedulingData.start_date = Time.parse(start_date)
  end

  def self.run(filename, start_date, initial_population_size, generations)
    SchedulingData.load_demand(filename)
    SchedulingData.start_date = Time.parse(start_date)

    puts "Beginning genetic search, please wait... "
    search = Ai4r::GeneticAlgorithm::GeneticSearch.new(initial_population_size, generations, SchedulingChromosome)
    result = search.run
    puts "FINAL CHROMOSOME"
    p result.display
    p result.fitness
  end
end


