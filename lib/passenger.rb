require "tty-prompt"
require "rainbow"

class Passenger < ActiveRecord::Base
  has_many :tickets
  has_many :journeys, through: :tickets

  def prompt
    TTY::Prompt.new
  end

  # Passenger#bookings returns a list of the current passenger's booked tickets

  def ticket_info
    # # Fix
    # self.tickets.map do |ticket|
    #   ticket.destinations
    # end
  end

  def first_class_interpret
    # Fix or delete
    self.passengers.map do |passenger|
      if passenger.first_class? == true
        return "First Class"
      else
        return "Economy Class"
      end
    end
  end

  def bookings
    if self.tickets.count > 0
      puts `clear`
      passenger_message = Artii::Base.new
      puts passenger_message.asciify("Passenger Portal")
      puts "Here is a list of your tickets: \n \n"
      self.journeys.map do |journey|
        # Fix: Add incrementing numbers, stop duplication, add first class interpolation
        puts "You will be traveling from #{journey.origin} to #{journey.destination} on #{journey.date}. Your train, number #{journey.train_number}, will make #{journey.num_of_stops} stop(s) along the route."
        # end
      end
    else
      puts "You don't have any bookings. Please return to the main menu to make a new reservation."
      more_help()
    end
  end

  # end

  def change_bookings
    if self.tickets.count > 0
      puts `clear`
      passenger_message = Artii::Base.new
      puts passenger_message.asciify("Passenger Portal")
      puts "Here is a list of your tickets: \n \n"
      change_options = self.journeys.map do |journey|
        # puts "You will be traveling from #{journey.origin} to #{journey.destination} on #{journey.date}."
        # end
        "#{journey.origin} to #{journey.destination} on #{journey.date}"
      end
      change_select = prompt.select("Which reservation would you like to change?", change_options)
      # puts change_input
    else
      puts "You don't have any bookings. Please return to the main menu to make a new reservation."
      more_help()
    end
  end

  # end

  # end

  # Passenger#new_booking allows the passenger to make buy a new ticket

  def new_booking
    # Fix
    new_ticket = Ticket.create(self.id)
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

# end
