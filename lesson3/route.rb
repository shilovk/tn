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

  def stations
    [from, interim, to].flatten
  end

  def show_stations
    puts [stations].join(', ')
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
    stations[index_of_station(old_station) + step]
  end

  def index_of_station(station)
    stations.index(station)
  end

  def get_back_station(actual_station)
    i = index_of_station(actual_station)
    back_station = is_from?(actual_station) ? 'none' : stations[i - 1]
  end

  def get_next_station(actual_station)
    i = index_of_station(actual_station)
    next_station = is_to?(actual_station) ? 'none' : stations[i + 1]
  end

  def get_three_stations(actual_station)
    [get_back_station(actual_station), actual_station, get_next_station(actual_station)]
  end
end
