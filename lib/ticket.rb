class Ticket < ActiveRecord::Base
  belongs_to :journey
  belongs_to :passenger

  #   Ticket#at_capacity will refuse to book a new ticket if the train is at capacity

  #   Ticket#cancel_journey cancels an entire trip (based on weather?)

end
