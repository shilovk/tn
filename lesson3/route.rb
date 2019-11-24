class Route
  attr_reader :from, :interim, :to

  def initialize(from, to, interim = [])
    @from = from
    @to = to
    @interim = interim
  end

  def add_interim(interim)
    self.interim << interim
  end

  def remove_interim(interim)
    self.interim.delete(interim) #if self.interim.include? interim
    puts self.interim
  end

  def array_of_stations
    [self.from].concat(self.interim).concat([self.to])
  end

  def show_array_of_stations
    array_of_stations.join(', ')
  end

  def get_actual_station_by(direction = nil, actual_station = nil)
    if actual_station.nil?
      self.from
    else
      case direction
      when 'next'
        is_to?(actual_station) ? self.to : find_actual_station(1, actual_station)
      when 'back'
        is_from?(actual_station) ? self.from : find_actual_station(-1, actual_station)
      else
        actual_station
      end
    end
  end

  def is_from?(station)
    station == self.from
  end

  def is_to?(station)
    station == self.to
  end

  def find_actual_station(step = 0, old_station)
    array_of_stations[index_of_station(old_station) + step]
  end

  def index_of_station(station)
    array_of_stations.index(station)
  end

  def get_three_stations(actual_station)
    i = index_of_station(actual_station)
    back_station = is_from?(actual_station) ? 'none' : array_of_stations[i - 1]
    next_station = is_to?(actual_station) ? 'none' : array_of_stations[i + 1]
    [back_station, actual_station, next_station]
  end
end
