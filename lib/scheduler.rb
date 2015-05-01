require 'ai4r'

Demand = Struct.new(:id, :minutes, :due_date)
class Data
  class << self
    attr_accessor :demands
  end

  def self.load_demand(filename)
    Data.demands = []
    CSV.foreach(filename) do |row|
      Data.demands << Demand.new(row[0].to_i, row[1].to_i, Time.parse(row[2]))
    end
  end
end

class SchedulingChromosome
  attr_accessor :normalized_fitness
  attr_accessor :sequence

  def initialize(demands)
    @sequence = demands
  end

  def fitness
    -1
  end

  def self.mutate(chromosome)
  end

  def self.reproduce(a, b)
    a
  end

  def self.seed
    SchedulingChromosome.new(Data.demands)
  end
end

puts "Initializing" 
Data.load_demand('demands.csv')
puts "Demand"
p Data.demands

puts "Beginning genetic search, please wait... "
initial_population_size = 800
generations = 1000


search = Ai4r::GeneticAlgorithm::GeneticSearch.new(initial_population_size, generations, SchedulingChromosome)
result = search.run
puts result.fitness
