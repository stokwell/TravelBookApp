class CreateBillings < ActiveRecord::Migration[5.1]
  def change
    create_table :billings do |t|
      t.references :trip, foreign_key: true
      t.integer :catering_costs

      t.timestamps
    end
  end
end
