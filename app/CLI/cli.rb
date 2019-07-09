require "artii"

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
  #   puts <<-DESK

  #     DESK
  welcome_message = Artii::Base.new
  puts welcome_message.asciify("Welcome!")
  puts "Are you a passenger?"
  user_type = get_input()
  if user_type == "yes"
    help_choice()
  elsif user_type == "no"
    employee_choice()
  else
    puts "Please enter a valid input."
  end
end

# Goodbye
def goodbye
  goodbye_message = Artii::Base.new
  puts goodbye_message.asciify("Goodbye!")
end

# Help choice
def help_choice
  puts "What can I help you with?"
  choices = <<-CHOICE
    1: View all my tickets
    2: Make a new reservation
    3: Change my reservation
    4: Upgrade to first class
    5: Cancel my reservation
    6: Exit
CHOICE
  puts choices
  user_choice = get_input()
  if user_choice == "1"
    view_bookings()
  elsif user_choice == "2"
    new_booking()
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
  puts "Is there anything else I can help you with today?"
  if get_input == "yes"
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
end

# Employee choice
def employee_choice
  puts "What can I help you with?"
  employee_choices = <<-CHOICE
  - 1: View a list of all the passengers on my train
  - 2: View the most popular destination
  - 3: View a list of the passengers with the most tickets booked
  - 4: Cancel the upcoming train journey
  - 5: Exit
CHOICE
  puts employee_choices
end
