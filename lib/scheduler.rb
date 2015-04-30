require 'ai4r'

class SchedulingChromosome
  attr_accessor :normalized_fitness

  def fitness
    -1
  end

  def self.mutate(chromosome)
  end

  def self.reproduce(a, b)
    SchedulingChromosome.new
  end

  def self.seed
    SchedulingChromosome.new
  end
end

puts "Beginning genetic search, please wait... "
initial_population_size = 800
generations = 1000
search = Ai4r::GeneticAlgorithm::GeneticSearch.new(initial_population_size, generations, SchedulingChromosome)
result = search.run
puts result.fitness
