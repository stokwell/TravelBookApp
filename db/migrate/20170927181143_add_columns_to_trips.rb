class AddColumnsToTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :notice, :text
    add_column :trips, :outlay, :integer, :default => 0
  end
end
