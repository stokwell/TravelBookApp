class AddFieldsForBilling < ActiveRecord::Migration[5.1]
  def change
    add_column :billings, :whole_days_count, :integer
    add_column :billings, :half_days_count, :integer

    add_column :billings, :night_count, :integer
    add_column :billings, :addition_for_night, :integer
    add_column :billings, :accommodations_per_diems, :integer

    add_column :billings, :addition_for_half_day, :integer
    add_column :billings, :addition_for_whole_day, :integer
    add_column :billings, :catering_costs_reduction, :integer

    add_column :billings, :breakfast_count, :integer
    add_column :billings, :lunch_count, :integer
    add_column :billings, :dinner_count, :integer

    add_column :billings, :breakfast_reduction, :integer
    add_column :billings, :lunch_reduction, :integer
    add_column :billings, :dinner_reduction, :integer

    add_column :billings, :result, :integer
  end
end
