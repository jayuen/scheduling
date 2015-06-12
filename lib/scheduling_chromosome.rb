class SchedulingChromosome
  attr_accessor :normalized_fitness
  attr_accessor :sequence
  attr_accessor :schedule_start_date
  attr_accessor :chromosome_fitness

  def initialize(demands, schedule_start_date=SchedulingData.start_date)
    @sequence = demands
    @schedule_start_date = schedule_start_date
    @chromosome_fitness = []
  end

  def fitness
    return @chromosome_fitness if @chromosome_fitness


    lateness_fitness = calculate_lateness_fitness
    # jitness = calculate_jitness

    @chromosome_fitness = [lateness_fitness, jitness]

    # @chromosome_fitness = lateness_fitness + jitness
  end

  def calculate_lateness_fitness
    chromosome_fitness = 0

    @sequence.each do |demand|
      gene_fitness = 0
      set_finish_date(demand) if demand.finished_date.nil?

      time_delta = demand.due_date - demand.finished_date

      if time_delta < 0
         gene_fitness = time_delta.to_f/(60*60) # hours late
      end

      chromosome_fitness += gene_fitness
    end

    chromosome_fitness
  end

  def calculate_jitness
    chromosome_fitness = 0

    @sequence.each do |demand|
      gene_fitness = 0
      set_finish_date(demand) if demand.finished_date.nil?

      time_delta = demand.finished_date - demand.due_date

      if time_delta < 0
         gene_fitness = time_delta.to_f/(60*60)
      end

      chromosome_fitness += gene_fitness
    end

    chromosome_fitness
  end

  def set_finish_date(demand)
    previous_finish_time = schedule_start_date

    @sequence.each do |demand|
      demand.finished_date = previous_finish_time + (demand.minutes.to_f * 60)
      previous_finish_time = demand.finished_date
    end
  end

  def set_finish_dates
    previous_finish_time = schedule_start_date

    @sequence.each do |demand|
      demand.finished_date = previous_finish_time + (demand.minutes.to_f * 60)
      previous_finish_time = demand.finished_date
    end
  end

  def display
    @sequence.map {|demand| demand.id}.join(' ')
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

    SchedulingChromosome.new(child_sequence, parent_a.schedule_start_date)
  end

  def self.seed
    SchedulingChromosome.new(SchedulingData.demands.shuffle, SchedulingData.start_date)
  end

  def self.score
    chromosome = SchedulingChromosome.new(SchedulingData.demands, SchedulingData.start_date)
    chromosome.fitness
  end
end
