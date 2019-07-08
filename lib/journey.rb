class Journey < ActiveRecord::Base
  has_many :passengers, through: :journeys
end
