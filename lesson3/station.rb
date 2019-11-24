class Station
  attr_reader :trains, :title

  def initialize(title)
    @title = title
    @trains = []
    puts "Station #{title} created!}"
  end

  def add_train(train)
    unless self.trains.include? train
      self.trains << train
      puts "Train #{train} arrived at the station #{self.title}"
    else
      raise "The train #{train} is already at the station #{self.title}"
    end
  end

  def show_types_of_trains
    puts "Trains by type: #{Train.get_types_of_trains(self.trains)}"
  end

  def send_train(train)
    if self.trains.include? train
      self.trains.delete(train)
      puts "Train #{train} left the station #{self.title}"
    else
      raise "The train #{train} is not at the station #{self.title}"
    end
  end
end
