require 'spec_helper'

describe GeneticAlgorithm::GeneticSearch do

  let(:now) {Time.now}
  let(:hour) {3600}
  let(:one_demand) {Demand.new(1, 10, nil, now + hour, 1)}

  let(:one_chromo) {SchedulingChromosome.new([one_demand])}
  let(:two_chromo) {SchedulingChromosome.new([one_demand])}
  let(:three_chromo) {SchedulingChromosome.new([one_demand])}

  it 'ranks chromosomes according to their pareto rank' do
    population_size = 3
    num_generations = 1
    one_chromo.chromosome_fitness = [3, 1]
    two_chromo.chromosome_fitness = [4, 2]
    three_chromo.chromosome_fitness = [1, 3]

    gs = GeneticAlgorithm::GeneticSearch.new(population_size, num_generations, SchedulingChromosome)

    gs.population = [one_chromo, two_chromo, three_chromo]

    gs.pareto_rank_population

    ranked_chromosomes = gs.population.sort{ |a, b| a.rank <=> b.rank }

    expect(ranked_chromosomes[0].rank).to be(1)
    expect(ranked_chromosomes[1].rank).to be(1)
    expect(ranked_chromosomes[2].rank).to be(2)
  end

end