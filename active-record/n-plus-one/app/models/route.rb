class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id,
    primary_key: :id

  def better_drivers_query
    buses = self.buses.includes(:drivers)

    all_drivers = Hash.new([])

    buses.each do |bus|
      drivers = bus.drivers.map { |driver| driver.name }
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end
end