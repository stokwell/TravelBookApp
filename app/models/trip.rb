class Trip < ApplicationRecord
  belongs_to :user
  has_one :billing
  validates_presence_of :trip_reason, :trip_start, :trip_end

  after_create :create_billing_for_trip

  def create_billing_for_trip
    self.billing = Billing.create(catering_costs: calculate_catering_costs)
  end

  private

  ADDITION_FOR_WHOLE_DAY = 24
  ADDITION_FOR_HALF_DAY = 12

  BREAKFAST_REDUCTION = ADDITION_FOR_WHOLE_DAY * 0.2
  LUNCH_REDUCTION = ADDITION_FOR_WHOLE_DAY * 0.4
  DINNER_REDUCTION = ADDITION_FOR_WHOLE_DAY * 0.2

  def accommodations_per_diems
    night_count * 20
  end

  def calculate_catering_costs
    trip_start == trip_end ? calculate_costs_for_half_day_or_nothing : calculate_costs_for_many_days_trip
  end

  def calculate_costs_for_half_day_or_nothing
    trip_end.hour - trip_start.hour > 8 ? ADDITION_FOR_HALF_DAY : 0
  end

  def calculate_costs_for_many_days_trip
    full_payed_days = (trip_start.to_date...trip_end.to_date).to_a.tap { |arr| arr.delete(trip_start.to_date) }.count
    costs = full_payed_days * ADDITION_FOR_HALF_DAY + 2 * ADDITION_FOR_HALF_DAY
  end

end
