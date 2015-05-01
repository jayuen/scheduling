require 'ai4r'
require './scheduling_chromosome'

class Data
  class << self
    attr_accessor :demands, :start_date
  end

  def self.load_demand(filename)
    Data.demands = []
    CSV.foreach(filename) do |row|
      Data.demands << Demand.new(row[0].to_i, row[1].to_i, 0, Time.parse(row[2]))
    end
  end
end


puts "Initializing" 
Data.load_demand('demands.csv')
Data.start_date = Time.parse('2015-05-01')
puts "Demand"
p Data.demands

puts "Beginning genetic search, please wait... "
initial_population_size = 500 # 800
generations = 100 #1000


search = Ai4r::GeneticAlgorithm::GeneticSearch.new(initial_population_size, generations, SchedulingChromosome)
result = search.run
puts "FINAL CHROMOSOME"
result.display
