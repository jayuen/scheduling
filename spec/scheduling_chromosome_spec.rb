require 'spec_helper'

describe SchedulingChromosome do
  let(:one) {Demand.new(1)}
  let(:two) {Demand.new(2)}
  let(:three) {Demand.new(3)}
  let(:four) {Demand.new(4)}

  describe 'reproduce' do
    it 'generates a child with a unique sequence' do
      a = SchedulingChromosome.new([one, two, three])
      b = SchedulingChromosome.new([one, two, three])

      child = SchedulingChromosome.reproduce(a,b)

      expect(child.sequence.uniq).to be_true
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
end

