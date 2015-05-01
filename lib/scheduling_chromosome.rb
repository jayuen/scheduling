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

    @chromosome_fitness = chromosome_fitness
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

  def self.reproduce(parent_a, parent_b)
    placeholder = 'tbd'
    tbd_indices = []
    child_sequence = []
    parent_a.sequence.each_with_index do |demand, i|
      if child_sequence.include?(parent_a.sequence[i]) && child_sequence.include?(parent_b.sequence[i]) 
        child_sequence << placeholder 
        tbd_indices << i
      else
        if (i % 2 == 0) 
          if child_sequence.include?(parent_a.sequence[i])
            child_sequence << parent_b.sequence[i]
          else 
            child_sequence << parent_a.sequence[i]
          end
        else
          if child_sequence.include?(parent_b.sequence[i])
            child_sequence << parent_a.sequence[i]
          else 
            child_sequence << parent_b.sequence[i]
          end
        end
      end      
    end

    unscheduled_demands = parent_a.sequence - child_sequence

    tbd_indices.each_with_index do |index, i|
      child_sequence[index] = unscheduled_demands[i]
    end

    raise unless child_sequence.uniq
    child_chromosome = SchedulingChromosome.new(child_sequence)

    puts "** REPRODUCING **"
    parent_a.display
    parent_b.display
    child_chromosome.display
    puts "** REPRODUCING **"

    child_chromosome

  end

  def self.seed
    SchedulingChromosome.new(Data.demands.shuffle)
  end
end
