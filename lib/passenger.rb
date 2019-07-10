class Passenger < ActiveRecord::Base
  has_many :tickets
  has_many :journeys, through: :tickets

  # Passenger#bookings returns a list of the current passenger's booked tickets

  def ticket_info
    # # Fix
    # self.tickets.map do |ticket|
    #   ticket.destinations
    # end
  end

  def bookings
    if self.tickets.count > 0
      puts `clear`
      passenger_message = Artii::Base.new
      puts passenger_message.asciify("Passenger Portal")
      puts "Here is a list of your tickets: \n \n"
      self.journeys.map do |journey|
        self.tickets.map do |ticket|
          # Fix: Add incrementing numbers
          puts "You will be traveling from #{journey.origin} to #{journey.destination} on #{journey.date}. Your train, number #{journey.train_number}, will make #{journey.num_of_stops} stop(s) along the route. The total purchase price for your ticket was $#{ticket.price}."
          # Fix

          # puts "The total purchase price for your ticket was $#{ticket.price}."
        end
      end
    else
      puts "You don't have any bookings. Please return to the main menu to make a new reservation."
    end
  end

  # Passenger#new_booking allows the passenger to make buy a new ticket

  def new_booking
    Ticket.create(name_input, nationality_input, age_input, first_class_input, luggage_input)
  end

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
