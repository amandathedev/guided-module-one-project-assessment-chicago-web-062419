require "tty-prompt"

class Journey < ActiveRecord::Base
  has_many :tickets
  has_many :passengers, through: :tickets

  @prompt = TTY::Prompt.new

  # More help
  def more_help
    help_option = @prompt.select("Is there anything else I can help you with today?", ["Yes", "No"])
    if help_option == "Yes"
      help_choice()
    else
      goodbye()
    end
  end

  #   Journey#passenger_list returns a list of passengers with tickets on this journey

  def passenger_list
  end

  #   Journey#most_popular_destination returns the most popular destination

  def self.most_popular_destination
    staff_banner()
    popular_destination_hash = Ticket.group(:journey_id).order("count_id ASC").limit(6).count(:id)
    puts "Here are the most popular destinations:"
    popular_destination_hash.select do |journey_id|
      # binding.pry
      unless journey_id == nil
        puts Journey.find(journey_id).destination
      end
    end
    more_help()
  end

  #   Journey#rewards_members returns a list of the 5 passengers with the most journeys traveled

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
