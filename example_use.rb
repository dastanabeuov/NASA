require_relative 'nasa_flight_calculator'

## Примеры использования

# Apollo 11
mass = 28801
route = [[:launch, "Earth"], [:land, "Moon"], [:launch, "Moon"], [:land, "Earth"]]
flight_calculator = NasaFlightCalculator.new(mass, route)
fuel_required = flight_calculator.calculate_fuel
puts "Apollo 11 fuel required: #{fuel_required}"

# Mission on Mars
mass = 14606
route = [[:launch, "Earth"], [:land, "Mars"], [:launch, "Mars"], [:land, "Earth"]]
flight_calculator = NasaFlightCalculator.new(mass, route)
fuel_required = flight_calculator.calculate_fuel
puts "Mission on Mars fuel required: #{fuel_required}"

# Passenger ship
mass = 75432
route = [
  [:launch, "Earth"], [:land, "Moon"], [:launch, "Moon"],
  [:land, "Mars"], [:launch, "Mars"], [:land, "Earth"]
]
flight_calculator = NasaFlightCalculator.new(mass, route)
fuel_required = flight_calculator.calculate_fuel
puts "Passenger ship fuel required: #{fuel_required}"
