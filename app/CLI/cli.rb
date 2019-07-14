require "artii"
require "tty-prompt"
require "rainbow"
require "tty-progressbar"
require "tty-spinner"

def prompt
  TTY::Prompt.new
end

def get_input
  gets.chomp
end

def find_user(get_input)
  passenger_check = Passenger.find(get_input)
  if passenger_check != nil
    passenger_check
  else
    return false
  end
end

def artii
  Artii::Base.new
end

def welcome_banner
  puts `clear`
  welcome_message = artii.asciify("Welcome!")
  puts Rainbow(welcome_message).blueviolet
end

def passenger_banner
  puts `clear`
  puts passenger_message = artii.asciify("Passenger Portal")
end

def staff_banner
  puts `clear`
  puts employee_message = artii.asciify("Staff Portal")
end

def enjoy_banner
  puts `clear`
  enjoy_message = artii.asciify("Enjoy your trip!")
  puts Rainbow(enjoy_message).royalblue
end

def main_menu
  welcome()
end

def train
  puts train = <<-TRAIN
                   .---._
           .--(. '  .).--.      . .-.
        . ( ' _) .)` (   .)-. ( ) '-'
       ( ,  ).        `(' . _)
     (')  _________      '-'
     ____[_________]                                         ________
     \\__/ | _ \\  ||    ,;,;,,                               [________]
     _][__|(")/__||  ,;;;;;;;;,   __________   __________   _| LILI |_
    /             | |____      | |          | |  ___     | |      ____|
   (| .--.    .--.| |     ___  | |   |  |   | |      ____| |____      |
   /|/ .. \\~~/ .. \\_|_.-.__.-._|_|_.-:__:-._|_|_.-.__.-._|_|_.-.__.-._|
+=/_|\\ '' /~~\\ '' /=+( o )( o )+==( o )( o )=+=( o )( o )+==( o )( o )=+=
='=='='--'==+='--'===+'-'=='-'==+=='-'+='-'===+='-'=='-'==+=='-'=+'-'jgs+
  TRAIN
end

def goodbye
  puts `clear`
  goodbye_message = artii.asciify("Goodbye!")
  puts Rainbow(goodbye_message).royalblue
end

def more_help
  help_option = prompt.select("Is there anything else I can help you with today?", ["Yes", "No"])
  if help_option == "Yes"
    welcome()
  else
    goodbye()
  end
end

def welcome
  welcome_banner()
  user_input = prompt.select(Rainbow("Are you a passenger or an employee?").royalblue, ["Passenger", "Employee"])
  if user_input == "Passenger"
    help_choice()
  elsif user_input == "Employee"
    employee_choice()
  else
    goodbye()
  end
end

def passenger_ID_validation(id)
  passenger_ID = gets.chomp.to_i
end

def passenger_exists?(id)
  Passenger.exists?(id)
end

def find_passenger(id)
  Passenger.find(id)
end

def delete_passenger(id)
  Passenger.destroy(id)
end

def help_choice
  passenger_banner()
  choices = prompt.select("What can I help you with?", ["View my current reservations", "Make a new reservation", "Upgrade to first class", "Cancel my reservations", "Return to main menu", "Exit"])
  if choices == "View my current reservations"
    view_bookings()
  elsif choices == "Make a new reservation"
    new_booking()
  elsif choices == "Upgrade to first class"
    upgrade_class()
  elsif choices == "Cancel my reservations"
    cancel()
  elsif choices == "Return to main menu"
    main_menu()
  else
    goodbye()
  end
end

# Read
def view_bookings
  passenger_banner()
  puts "Please enter your passenger ID number."
  view_id = gets.chomp.to_i
  if view_id != 0
    if passenger_exists?(view_id)
      current_passenger = find_user(view_id)
      puts current_passenger.bookings
    else
      passenger_banner()
      puts "No account found matching this ID number. Please return to the main menu to create a new account or book a trip."
      more_help()
    end
  else
    puts "Please enter a number."
    sleep(2)
    view_bookings()
  end
end

# Update
def upgrade_class
  puts passenger_banner()
  puts "Please enter your passenger ID number."
  upgrade_id = gets.chomp.to_i
  if passenger_exists?(upgrade_id)
    current_passenger = find_user(upgrade_id)
    puts current_passenger.upgrade
    # binding.pry
    more_help()
  else
    passenger_banner()
    puts "No account found matching this ID number. Please return to the main menu to create a new account or book a trip."
    more_help()
  end
end

# Delete
def cancel
  passenger_banner()
  puts "Please enter your passenger ID number."
  passenger_ID = gets.chomp.to_i
  if passenger_exists? (passenger_ID)
    current_passenger = find_user(passenger_ID)
    current_passenger.destroy
    passenger_banner()
    puts "Your reservations have been canceled. You should see a refund on your credit card in 3-5 business days."
    puts credit = <<-CREDIT
    ,,,,,,,,,,,,,,,,,,,$$$$
    ,,,,,,,,,,,$$$$$$$$$$$$$$$$$$$
    ,,,,,,,$$$$$$$$$$$$$$$$$$$$$$$$$
    ,,,,,$$$$$$$,,,,,,,$$$$,,,,$$$$$$$$
    ,,,$$$$$$,,,,,,,,,,$$$$,,,,,,,,$$$$$$$
    ,,$$$$$$,,,,,,,,,,,$$$$,,,,,,,,,,$$$$$$
    ,,$$$$$$,,,,,,,,,,,$$$$
    ,,$$$$$$,,,,,,,,,,,$$$$
    ,,,$$$$$$,,,,,,,,,,$$$$
    ,,,,$$$$$$$$,,,,,,,$$$$
    ,,,,,,$$$$$$$$$$$$$$$$$
    ,,,,,,,,,,$$$$$$$$$$$$$$$$$$
    ,,,,,,,,,,,,,,,,,$$$$$$$$$$$$$$$$
    ,,,,,,,,,,,,,,,,,,,$$$$,$$$$$$$$$$
    ,,,,,,,,,,,,,,,,,,,$$$$,,,,,,,$$$$$$$
    ,,,,,,,,,,,,,,,,,,,$$$$,,,,,,,,,,$$$$$$
    ,,,,,,,,,,,,,,,,,,,$$$$,,,,,,,,,,,$$$$$$
    $$$$$$$,,,,,,,,,,,,$$$$,,,,,,,,,,$$$$$$$
    ,$$$$$$,,,,,,,,,,,,$$$$,,,,,,,,,,$$$$$$$
    ,,$$$$$$$,,,,,,,,,,$$$$,,,,,,,,$$$$$$$$
    ,,,$$$$$$$$,,,,,,,,$$$$,,,,,,$$$$$$$$
    ,,,,,,$$$$$$$$$$$$$$$$$$$$$$$$$$$$
    ,,,,,,,,,,$$$$$$$$$$$$$$$$$$$$$
    ,,,,,,,,,,,,,,,,,,$$$$$$$$
                                                                                                                       
    CREDIT
    more_help()
  else
    puts "No account found matching this ID number. Please return to the main menu to create a new account or book a trip."
    more_help()
  end
end

# Create
def new_booking
  # Spinner
  spinner = TTY::Spinner.new("  :spinner   Loading ... ", format: :spin_2)
  spinner.auto_spin
  sleep(1)
  spinner.stop()
  # Questions
  puts "Please tell me your full name."
  name_input = get_input()
  if name_input.length < 3
    puts "Please enter a valid name."
    name_input = get_input()
  end
  puts "Please enter your country of origin."
  nationality_input = get_input()
  if nationality_input.length < 3
    puts "Please enter a valid country."
    nationality_input = get_input()
  end
  puts "How old are you?"
  age_input = get_input()
  puts "Are you interested in purchasing a first-class ticket?"
  first_class_input = get_input()
  puts "How many pieces of luggage are you traveling with?"
  luggage_input = luggage_choice()
  #   Fix: Choose destination
  new_passenger = Passenger.create(name: name_input, nationality: nationality_input, age: age_input, first_class?: first_class_input, num_of_bags: luggage_input)
  # new_ticket = Ticket.create(tickets.id: self.id)
end

# Create
def luggage_choice
  luggage_input = gets.chomp.to_i
  if luggage_input.to_i > 4
    puts "Sorry, we allow a maximum of four bags per passenger. Please enter a new number."
    luggage_choice()
  elsif luggage_input.to_i > 0 && luggage_input.to_i <= 4
    puts "Thank you!"
    sleep(0.7)
    puts `clear`
    # Processing reservation
    processing_message = artii
    processing_message = processing_message.asciify("Processing your reservation:")
    puts Rainbow(processing_message).royalblue
    # Progress bar
    bar = TTY::ProgressBar.new("[:bar]", width: 130, total: 50)
    50.times do
      sleep(0.02)
      bar.advance(1)
    end
    enjoy_banner()
    train()
    sleep(3)
    more_help()
  else
    puts "Please enter a valid number."
    luggage_choice()
    luggage_input = gets.chomp.to_i
  end
  luggage_input
end

def employee_choice
  staff_banner()
  employee_choices = prompt.select("What can I help you with?", ["View a list of all the upcoming trains", "View the most popular destination", "View a list of the passengers with the most tickets booked", "Return to main menu", "Exit"])
  if employee_choices == "View a list of all the upcoming trains"
    Journey.all_trains()
  elsif employee_choices == "View the most popular destination"
    Journey.most_popular_destination()
  elsif employee_choices == "View a list of the passengers with the most tickets booked"
    Journey.rewards_members()
  elsif employee_choices == "Return to main menu"
    main_menu()
  else
    goodbye()
    sleep(1)
    puts `clear`
  end
end
