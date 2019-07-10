require "artii"
require "tty-prompt"
require "rainbow"
# https://github.com/sickill/rainbow
require "tty-progressbar"
require "tty-spinner"

@prompt = TTY::Prompt.new

# Input
def get_input
  gets.chomp.downcase
end

# Find user
def find_user(get_input)
  Passenger.find(get_input)
end

# Welcome Banner
def welcome_banner
  puts `clear`
  welcome_message = Artii::Base.new
  welcome_message = welcome_message.asciify("Welcome!")
  puts Rainbow(welcome_message).blueviolet
end

# Passenger Portal Banner
def passenger_banner
  puts `clear`
  passenger_message = Artii::Base.new
  puts passenger_message.asciify("Passenger Portal")
end

# Staff Banner
def staff_banner
  puts `clear`
  employee_message = Artii::Base.new
  puts employee_message.asciify("Staff Portal")
end

# Enjoy your trip banner
def enjoy_banner
  puts `clear`
  enjoy_message = Artii::Base.new
  enjoy_message = enjoy_message.asciify("Enjoy your trip!")
  puts Rainbow(enjoy_message).royalblue
end

# Train
def train
  # Fix
  puts `asciinema play 234381.cast`
end

# Goodbye
def goodbye
  puts `clear`
  goodbye_message = Artii::Base.new
  goodbye_message = goodbye_message.asciify("Goodbye!")
  puts Rainbow(goodbye_message).royalblue
end

# More help
def more_help
  help_option = @prompt.select("Is there anything else I can help you with today?", ["Yes", "No"])
  if help_option == "Yes"
    welcome()
  else
    goodbye()
  end
end

# Welcome
def welcome
  welcome_banner()
  # User input
  user_input = @prompt.select(Rainbow("Are you a passenger or an employee?").royalblue, ["Passenger", "Employee"])
  # Selection
  if user_input == "Passenger"
    help_choice()
  elsif user_input == "Employee"
    employee_choice()
  else
    goodbye()
  end
end

# Help choice
def help_choice
  passenger_banner()
  #   User input
  choices = @prompt.select("What can I help you with?", ["View my current reservations", "Make a new reservation", "Change my reservation", "Upgrade to first class", "Cancel my reservation", "Exit"])
  #   Selection
  if choices == "View my current reservations"
    view_bookings()
  elsif choices == "Make a new reservation"
    new_booking()
  elsif choices == "Change my reservation"
    puts `clear`
    puts "Please enter your passenger ID number."
    change_reservation_ID = gets.chomp.to_i
    if change_reservation_ID >= 1 && change_reservation_ID <= 500
      current_passenger = find_user(change_reservation_ID)
      puts current_passenger.change_bookings
      more_help()
    else
      puts "Please enter a valid passenger ID."
      change_reservation_ID = gets.chomp.to_i
      if change_reservation_ID >= 1 && change_reservation_ID <= 500
        current_passenger = find_user(change_reservation_ID)
        puts current_passenger.change_bookings
        more_help()
      else
        goodbye()
      end
    end
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
  passenger_banner()
  puts "Please enter your passenger ID number."
  passenger_ID_input = gets.chomp.to_i
  if passenger_ID_input >= 1 && passenger_ID_input <= 500
    current_passenger = find_user(passenger_ID_input)
    puts current_passenger.bookings
    more_help()
  else
    puts "Please enter a valid passenger ID."
    passenger_ID_input = gets.chomp.to_i
    if passenger_ID_input >= 1 && passenger_ID_input <= 500
      current_passenger = find_user(passenger_ID_input)
      puts current_passenger.bookings
      more_help()
    else
      goodbye()
    end
  end
end

# New booking
def new_booking
  # Add a new passenger to the database
  # Spinner
  spinner = TTY::Spinner.new("  :spinner   Loading ... ", format: :spin_2)
  spinner.auto_spin # Automatic animation with default interval
  sleep(1) # Perform task
  spinner.stop() # Stop animation
  # Questions
  puts "Please tell me your full name."
  name_input = get_input()
  # if name_input
  puts "Please enter your country of origin."
  nationality_input = get_input()
  puts "How old are you?"
  age_input = get_input()
  puts "Are you interested in purchasing a first-class ticket?"
  first_class_input = get_input()
  puts "How many pieces of luggage are you traveling with?"
  luggage_input = luggage_choice()
  #   Fix
  # Choose destination
  new_passenger = Passenger.create(name: name_input, nationality: nationality_input, age: age_input, first_class?: first_class_input, num_of_bags: luggage_input)
  #   new_ticket = new_passenger.new_booking
end

def luggage_choice
  luggage_input = gets.chomp.to_i
  if luggage_input.to_i > 4
    # Fix
    puts "Sorry, we allow a maximum of four bags per passenger. Please enter a new number."
    luggage_choice()
  elsif luggage_input.to_i > 0 && luggage_input.to_i <= 4
    puts "Thank you!"
    sleep(0.7)
    puts `clear`
    # Processing reservation
    processing_message = Artii::Base.new
    processing_message = processing_message.asciify("Processing your reservation:")
    puts Rainbow(processing_message).royalblue
    # Progress bar
    bar = TTY::ProgressBar.new("[:bar]", width: 130, total: 50)
    50.times do
      sleep(0.07)
      bar.advance(1)
    end
    enjoy_banner()
    # Fix
    # train()
  else
    puts "Please enter a valid number."
    luggage_choice()
    luggage_input = gets.chomp.to_i
  end
  luggage_input
end

# Change reservation
def change_reservation
  # Fix
  current_passenger = Passenger.find
  current_passenger.change_bookings()
end

# Upgrade
def upgrade
end

# Cancel reservation
def cancel_reservation
end

# Employee choice
def employee_choice
  staff_banner()
  #   User input
  employee_choices = @prompt.select("What can I help you with?", ["View a list of all the passengers on my train", "View the most popular destination", "View a list of the passengers with the most tickets booked", "Cancel the upcoming train journey", "Exit"])
  #   Selection
  if employee_choices == "View a list of all the passengers on my train"
  elsif employee_choices == "View the most popular destination"
    Journey.most_popular_destination()
  elsif employee_choices == "View a list of the passengers with the most tickets booked"
    Journey.rewards_members()
  elsif employee_choices == "Cancel the upcoming train journey"
  else
    goodbye()
    sleep(4)
    puts `clear`
  end
end
