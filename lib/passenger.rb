class Passenger < ActiveRecord::Base
  has_many :tickets
  has_many :journeys, through: :tickets

  # Passenger#bookings returns a list of the current passenger's booked tickets

  def bookings
    if self.tickets.count > 0
      return self.tickets
    else
      puts "You don't have any bookings."
    end
  end

  #   Passenger#new_booking allows the passenger to make buy a new ticket

  # Passenger#booking_destinations returns a list of all destinations for booked tickets

  def booking_destinations
  end

  # Passenger#change_reservation allows a passenger to modify a ticket (destination)

  def change_reservation
  end

  # Passenger#upgrade allows a passenger to change their ticket to first-class

  def upgrade
  end

  # Passenger#refund allows a passenger to cancel their reservation

  def refund
  end
end
