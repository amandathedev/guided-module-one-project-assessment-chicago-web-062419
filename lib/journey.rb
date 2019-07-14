require "artii"
require "tty-prompt"
require "rainbow"
require "tty-progressbar"
require "tty-spinner"
require "table_print"

class Journey < ActiveRecord::Base
  has_many :tickets
  has_many :passengers, through: :tickets

  @prompt = TTY::Prompt.new

  def more_help
    help_option = @prompt.select("Is there anything else I can help you with today?", ["Yes", "No"])
    if help_option == "Yes"
      help_choice()
    else
      goodbye()
    end
  end

  # Read
  def self.all_trains
    staff_banner()
    tp self.all
    sleep(3)
    more_help()
  end

  # Read
  def self.most_popular_destination
    staff_banner()
    popular_destination_hash = Ticket.group(:journey_id).order("count_id ASC").limit(6).count(:id)
    puts "Here are the most popular destinations:"
    popular_destination_hash.select do |journey_id|
      unless journey_id == nil
        puts Journey.find(journey_id).destination
      end
    end
    more_help()
  end

  # Read
  def self.rewards_members
    staff_banner()
    rewards_members_hash = Ticket.group(:passenger_id).order("count_id DESC").limit(5).count(:id)
    puts "Here are the top five rewards members:"
    rewards_members_hash.select do |passenger_id|
      puts Passenger.find(passenger_id).name
    end
    more_help()
  end
end
