require 'ai4r'

class SchedulingChromosome
  def fitness
    -1
  end

  def normalized_fitness
    -1
  end

  def normalized_fitness= args
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
search = Ai4r::GeneticAlgorithm::GeneticSearch.new(800, 100, SchedulingChromosome)
result = search.run
puts result.fitness
