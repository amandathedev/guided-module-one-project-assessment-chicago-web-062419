class Ticket < ActiveRecord::Base
  belongs_to :journey
  belongs_to :passenger
end
