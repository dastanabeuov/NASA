class NasaFlightCalculator
  PLANET_GRAVITIES = {
    "Earth" => 9.807,
    "Moon" => 1.62,
    "Mars" => 3.711
  }.freeze

  LAUNCH_FUEL_FACTOR = 0.042
  LANDING_FUEL_FACTOR = 0.033
  LAUNCH_FUEL_OFFSET = 33
  LANDING_FUEL_OFFSET = 42

  def initialize(ship_mass, flight_route)
    @ship_mass = ship_mass
    @flight_route = flight_route
    @total_fuel = 0
  end

  def calculate_fuel
    @flight_route.each do |step|
      directive = step[0]
      target_planet = step[1]

      fuel = calculate_step_fuel(directive, target_planet)
      @total_fuel += fuel

      # Вычисляем дополнительное топливо для посадки на Луну
      if directive == :land && target_planet == "Moon"
        additional_fuel = calculate_additional_fuel(target_planet)
        @total_fuel += additional_fuel
      end

      update_ship_mass(fuel)
    end

    @total_fuel
  end

  private

  def calculate_step_fuel(directive, target_planet)
    gravity = PLANET_GRAVITIES[target_planet]

    if gravity.nil?
      # Вернуть 0 или другое значение по умолчанию, если gravity не определено
      return 0
    end

    if directive == :launch
      # Формула для вычисления топлива при запуске
      (fuel_formula(gravity, LAUNCH_FUEL_FACTOR) - LAUNCH_FUEL_OFFSET).to_i
    elsif directive == :land
      # Формула для вычисления топлива при посадке
      (fuel_formula(gravity, LANDING_FUEL_FACTOR) - LANDING_FUEL_OFFSET).to_i
    else
      0
    end
  end

  def fuel_formula(gravity, factor)
    # Формула для вычисления топлива: масса * гравитация * коэффициент
    @ship_mass * gravity * factor
  end

  def calculate_additional_fuel(target_planet)
    launch_gravity = PLANET_GRAVITIES["Earth"]
    # Вычисляем топливо для запуска с Земли и посадки на целевую планету
    additional_fuel = calculate_step_fuel(:launch, launch_gravity)
    additional_fuel + calculate_step_fuel(:land, target_planet)
  end

  def update_ship_mass(fuel)
    # Обновляем массу судна с учетом добавленного топлива
    @ship_mass += fuel
  end
end
