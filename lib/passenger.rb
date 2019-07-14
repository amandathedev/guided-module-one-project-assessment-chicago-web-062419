require "tty-prompt"
require "rainbow"

class Passenger < ActiveRecord::Base
  has_many :tickets
  has_many :journeys, through: :tickets

  def prompt
    TTY::Prompt.new
  end

  def artii
    Artii::Base.new
  end

  def passenger_banner
    puts `clear`
    puts passenger_message = artii.asciify("Passenger Portal")
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

  # Read
  def bookings
    if self.tickets.count > 0
      passenger_banner()
      puts "Here is a list of your tickets:"
      self.journeys.map do |journey|
        puts "You will be traveling from #{journey.origin} to #{journey.destination} on #{journey.date}. Your train, number #{journey.train_number}, will make #{journey.num_of_stops} stop(s) along the route."
      end
      more_help()
    else
      puts "You don't have any bookings. Please return to the main menu to make a new reservation."
      more_help()
    end
  end

  # Update
  def upgrade
    if self.tickets.count > 0
      passenger_banner()
      puts "Here is a list of your tickets:"
      change_options = self.journeys.map do |journey|
        "#{journey.origin} to #{journey.destination} on #{journey.date}"
      end
      passenger_banner()
      change_select = prompt.select("Which reservation would you like to change?", change_options)
      passenger_banner()
      puts "The cost to upgrade this journey is $#{rand(25..100)}."
      upgrade_select = prompt.select("Would you like to proceed with the upgrade?", ["Yes", "No"])
      if upgrade_select == "Yes"
        money = <<-MONEY
        ||====================================================================||
        ||//$\\\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\//$\\\\||
        ||(100)==================| FEDERAL RESERVE NOTE |================(100)||
        ||\\\\$//        ~         '------========--------'                \\\\$//||
        ||<< /        /$\\              // ____ \\\\                         \\ >>||
        ||>>|  12    //L\\\\            // ///..) \\\\         L38036133B   12 |<<||
        ||<<|        \\\\ //           || <||  >\\  ||                        |>>||
        ||>>|         \\$/            ||  $$ --/  ||        One Hundred     |<<||
     ||====================================================================||>||
     ||//$\\\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\//$\\\\||<||
     ||(100)==================| FEDERAL RESERVE NOTE |================(100)||>||
     ||\\\\$//        ~         '------========--------'                \\\\$//||\\||
     ||<< /        /$\\              // ____ \\\\                         \\ >>||)||
     ||>>|  12    //L\\\\            // ///..) \\\\         L38036133B   12 |<<||/||
     ||<<|        \\\\ //           || <||  >\\  ||                        |>>||=||
     ||>>|         \\$/            ||  $$ --/  ||        One Hundred     |<<||
     ||<<|      L38036133B        *\\\\  |\\_/  //* series                 |>>||
     ||>>|  12                     *\\\\/___\\_//*   1989                  |<<||
     ||<<\\      Treasurer     ______/Franklin\\________     Secretary 12 />>||
     ||//$\\                 ~|UNITED STATES OF AMERICA|~               /$\\\\||
     ||(100)===================  ONE HUNDRED DOLLARS =================(100)||
     ||\\\\$//\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\\\$//||
     ||====================================================================||
        MONEY
        puts "#{money}"
        self.update(first_class?: true)
        sleep(3)
        puts "\n Thank you for your purchase!"
        sleep(2)
        enjoy_banner()
        train()
      else
        # puts "You don't have any bookings. Please return to the main menu to make a new reservation."
        # more_help()
      end
    else
      puts "You don't have any bookings. Please return to the main menu to make a new reservation."
      more_help()
    end
  end
end

# Stretch goals: Validations, destination list for new bookings
# Struggles: update method name, calling methods with relation to scope, getting the right ID from the join table and not the models, embedded methods
# Learned: using gems, behavior-driven development, seeding database
