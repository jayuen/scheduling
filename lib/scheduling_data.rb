require 'csv'

class SchedulingData
  class << self
    attr_accessor :demands, :start_date
  end

  def self.load_demand(filename)
    SchedulingData.demands = []
    CSV.foreach(filename) do |row|
      SchedulingData.demands << Demand.new(row[0].to_i, row[1].to_i, 0, Time.parse(row[2]))
    end
  end
end
