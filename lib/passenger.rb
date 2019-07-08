class Passenger < ActiveRecord::Base
  has_many :flights, through: :tickets
end
