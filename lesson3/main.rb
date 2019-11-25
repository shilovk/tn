load 'station.rb'
load 'route.rb'
load 'train.rb'

my_station1 = Station.new('Moscow')
my_train1 = Train.new('Strij', 'passenger', 11)
my_station1.add_train(my_train1)
my_train2 = Train.new('Volga', 'passenger', 7)
my_station1.add_train(my_train2)
my_train3 = Train.new('Loocoil', 'freight', 58)
my_station1.add_train(my_train3)
puts my_station1.trains
my_station1.show_trains_by_type('passenger')
my_station1.send_train(my_train2)
puts my_station1.trains

puts my_route1 = Route.new('Moscow', 'Sochi')
my_route1.add_interim('Krasnodar')
my_route1.add_interim('Adler')
my_route1.show_stations

my_route1.remove_interim('Adler')
my_route1.show_stations
my_train2.add_speed(15)
puts my_train2.speed
my_train2.stop_speed
puts my_train2.speed
puts my_train2.coach_count
my_train2.add_coach
my_train2.add_coach
puts my_train2.coach_count
my_train2.remove_coach
puts my_train2.coach_count
puts my_train2.add_route(my_route1)
my_train2.set_actual_station('next')
puts my_train2.three_stations
my_train2.set_actual_station('next')
puts my_train2.three_stations
my_train2.set_actual_station('back')
puts my_train2.three_stations

