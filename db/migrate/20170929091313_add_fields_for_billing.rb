class AddFieldsForBilling < ActiveRecord::Migration[5.1]
  def change
    add_column :billings, :night_count, :integer
    add_column :billings, :addition_for_night, :integer
    add_column :billings, :accommodations_per_diems, :integer


    add_column :billings, :addition_for_night, :integer
    add_column :billings, :addition_for_half_day, :integer
    add_column :billings, :addition_addition_for_half_day, :integer

    add_column :billings, :catering_costs_reduction, :integer
    add_colum :billings, :result, :integer
  end
end
