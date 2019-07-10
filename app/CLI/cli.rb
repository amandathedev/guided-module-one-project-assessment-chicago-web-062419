require "artii"
require "tty-prompt"
require "rainbow"
# require "pastel"
# https://www.rubydoc.info/gems/tty-color

@prompt = TTY::Prompt.new

# Input
def get_input
  gets.chomp.downcase
end

# Find user
def find_user(get_input)
  Passenger.find(get_input)
end

# Welcome
def welcome
  puts `clear`
  welcome_message = Artii::Base.new
  welcome_message = welcome_message.asciify("Welcome!")
  puts Rainbow(welcome_message).blueviolet
  user_input = @prompt.select(Rainbow("Are you a passenger or an employee?").royalblue, ["Passenger", "Employee"])
  if user_input == "Passenger"
    help_choice()
  elsif user_input == "Employee"
    employee_choice()
  else
    goodbye()
  end
end

# Goodbye
def goodbye
  puts `clear`
  goodbye_message = Artii::Base.new
  goodbye_message = goodbye_message.asciify("Goodbye!")
  puts Rainbow(goodbye_message).royalblue
end

# Help choice
def help_choice
  puts `clear`
  passenger_message = Artii::Base.new
  puts passenger_message.asciify("Passenger Portal")
  choices = @prompt.select("What can I help you with?", ["View my current reservations", "Make a new reservation", "Change my reservation", "Upgrade to first class", "Cancel my reservation", "Exit"])
  puts choices
  if choices == "View my current reservations"
    view_bookings()
  elsif choices == "Make a new reservation"
    new_booking()
  elsif choices == "Change my reservation"
    # Change reservation
  elsif choices == "Upgrade to first class"
    # Upgrade
  elsif choices == "Cancel my reservation"
    # Cancel
  else
    goodbye()
  end
end

# View bookings
def view_bookings
  puts "Please enter your passenger ID number."
  passenger_ID_input = gets.chomp.to_i
  if passenger_ID_input > 500
    puts "Please enter a valid passenger ID."
    view_bookings()
  else
    current_passenger = find_user(passenger_ID_input)
    puts current_passenger.bookings
    more_help()
  end
end

# More help
def more_help
  help_option = @prompt.select("Is there anything else I can help you with today?", ["Yes", "No"])
  if help_option == "Yes"
    help_choice()
  else
    goodbye()
  end
end

# New booking
def new_booking
  # Add a new passenger to the database
  puts "Please tell me your full name."
  name_input = get_input()
  puts "Please enter your country of origin."
  nationality_input = get_input()
  puts "How old are you?"
  age_input = get_input()
  puts "Are you interested in purchasing a first-class ticket?"
  first_class_input = get_input()
  puts "How many pieces of luggage are you traveling with?"
  luggage_input = gets.chomp.to_i
  if luggage_input.to_i > 4
    puts "Sorry, we allow a maximum of four bags per passenger."
  elsif luggage_input > 1 && luggage_input < 4
    puts "Thank you!"
  else
    puts "Please enter a valid number."
    # Restart only this question
    luggage_input = gets.chomp.to_i
  end
  #   Fix
  Passenger.new_booking
end

# Change reservation
def change_reservation
end

# Upgrade
def upgrade
end

# Cancel reservation
def cancel_reservation
end

# Employee choice
def employee_choice
  puts `clear`
  employee_message = Artii::Base.new
  puts employee_message.asciify("Staff Portal")
  employee_choices = @prompt.select("What can I help you with?", ["View a list of all the passengers on my train", "MView the most popular destination", "View a list of the passengers with the most tickets booked", "Cancel the upcoming train journey", "Exit"])
  puts employee_choices
end
