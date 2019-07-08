class CreatePassengers < ActiveRecord::Migration[5.0]
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :nationality
      t.integer :age
      t.boolean :first_class?
      t.integer :num_of_bags
    end
  end
end
