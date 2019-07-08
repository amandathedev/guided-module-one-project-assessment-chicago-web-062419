class CreateJourneys < ActiveRecord::Migration[5.0]
  def change
    create_table :journeys do |t|
      t.integer :train_number
      t.string :origin
      t.string :destination
      t.integer :capacity
      t.date :date
      t.integer :num_of_stops
    end
  end
end
