class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.references :user, foreign_key: true

      t.string :trip_reason
      t.datetime :trip_start
      t.datetime :trip_end
      t.string :trip_departure
      t.string :trip_arrival
      t.integer :distance

      t.integer :night_count, :default => 0
      t.integer :breakfast_count, :default => 0
      t.integer :lunch_count, :default => 0
      t.integer :dinner_count, :default => 0

      t.timestamps
    end
  end
end
