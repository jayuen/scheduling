require 'spec_helper'

describe SchedulingChromosome do
  let(:now) {Time.now}
  let(:hour) {3600}
  let(:one) {Demand.new(1, 10, nil, now + hour)}
  let(:two) {Demand.new(2, 20, nil, now + 2*hour)}
  let(:three) {Demand.new(3, 30, nil, now + 3*hour)}
  let(:four) {Demand.new(4, 40, nil, now + 4*hour)}

  describe 'reproduce' do
    it 'generates a child with a unique sequence' do
      a = SchedulingChromosome.new([one, two, three])
      b = SchedulingChromosome.new([one, two, three])

      child = SchedulingChromosome.reproduce(a,b)

      expect(child.sequence).to eq(child.sequence.uniq)
    end

    it 'alternates between parents' do
      a = SchedulingChromosome.new([one, two, three, four])
      b = SchedulingChromosome.new([one, four, three, two])

      child = SchedulingChromosome.reproduce(a, b)

      expect(child.sequence).to eq([one, four, three, two])
    end

    it 'skips demands that are already in the child, then selects from other parent' do
      a = SchedulingChromosome.new([one, two, three, four])
      b = SchedulingChromosome.new([four, three, two, one])

      child = SchedulingChromosome.reproduce(a, b)

      expect(child.sequence).to eq([one, three, two, four])
    end
  end

  describe 'fitness' do
    it 'returns a negative score for lateness' do
      one.due_date = now
      one.minutes = 60
      chromo = SchedulingChromosome.new([one], now)

      expect(chromo.calculate_lateness_fitness).to be < 0
    end

    it 'returns a negative score when early' do
      one.due_date = now+2*hour
      one.minutes = 60
      chromo = SchedulingChromosome.new([one], now)

      expect(chromo.calculate_jitness).to be < 0
    end

    it 'updates the fitness object' do

    end

  end
end

