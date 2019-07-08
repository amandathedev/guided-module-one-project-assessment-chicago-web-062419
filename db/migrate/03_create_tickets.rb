class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :passenger_id
      t.integer :train_id
      t.integer :ticket_number
      t.integer :price
    end
  end
end
