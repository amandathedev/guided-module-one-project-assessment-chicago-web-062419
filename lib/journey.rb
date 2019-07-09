class Journey < ActiveRecord::Base
  has_many :tickets
  has_many :passengers, through: :tickets

  #   Journey#passenger_list returns a list of passengers with tickets on this journey

  def passenger_list
    journey_one = Journey.all[0]
    journey_one.select
  end

  #   Journey#most_popular_destination returns the most popular destination

  def most_popular_destination
    Tickets.all.map
  end

  #   Journey#rewards_members returns a list of the 5 passengers with the most journeys traveled

  def rewards_members
  end
end
