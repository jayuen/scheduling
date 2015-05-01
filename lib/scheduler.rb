require 'ai4r'

Demand = Struct.new(:id, :minutes, :finished_date, :due_date)
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

class SchedulingChromosome
  attr_accessor :normalized_fitness
  attr_accessor :sequence

  def initialize(demands)
    @sequence = demands
  end

  def fitness
    return @chromosome_fitness if @chromosome_fitness

    chromosome_fitness = 0
    previous_finish_time = Data.start_date

    # calculate finished_time
    sequence.each do |demand|
      demand.finished_date = previous_finish_time + (demand.minutes.to_f * 60) 
      previous_finish_time = demand.finished_date

      # p demand
    end

    # assesses fitness of entire population
    sequence.each do |demand|
    
      # calculate fitness
      gene_fitness = 0

      time_delta = demand.due_date - demand.finished_date

     if time_delta < 0 # it's late
        gene_fitness = time_delta.to_f/(60*60) # hours late        
      end

      chromosome_fitness += gene_fitness
    end

    @chromosome_fitness = chromosome_fitness * -1
    puts "**** CHROMOSOME ***** "
    display
    @chromosome_fitness
  end

  def display
    p @sequence.map {|demand| demand.id}.join(' ')
    p @chromosome_fitness
  end

  def self.mutate(chromosome)
  end

  def self.reproduce(a, b)
    a
  end

  def self.seed
    SchedulingChromosome.new(Data.demands.shuffle)
  end
end

puts "Initializing" 
Data.load_demand('demands.csv')
Data.start_date = Time.parse('2015-05-01')
puts "Demand"
p Data.demands

puts "Beginning genetic search, please wait... "
initial_population_size = 10 # 800
generations = 1 #1000


search = Ai4r::GeneticAlgorithm::GeneticSearch.new(initial_population_size, generations, SchedulingChromosome)
result = search.run
puts "FINAL CHROMOSOME"
result.display
