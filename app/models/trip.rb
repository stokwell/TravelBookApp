class Trip < ApplicationRecord
  belongs_to :user
  has_one :billing
  validates_presence_of :trip_reason, :trip_start, :trip_end

  after_create :create_billing_for_trip

  def create_billing_for_trip
    self.billing = Billing.create(

      night_count: night_count,
      addition_for_night: ADDITION_FOR_NIGHT,
      accommodations_per_diems: accommodations_per_diems,

      addition_for_night: ADDITION_FOR_NIGHT,
      addition_for_half_day: ADDITION_FOR_HALF_DAY,
      addition_for_whole_day: ADDITION_FOR_WHOLE_DAY,

      catering_costs: calculate_catering_costs,
      catering_costs_reduction: catering_costs_reduction,
      result: result

    )
  end

  protected

  ADDITION_FOR_WHOLE_DAY = 24
  ADDITION_FOR_HALF_DAY = 12
  ADDITION_FOR_NIGHT = 10

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

  def catering_costs_reduction
    breakfast_count * BREAKFAST_REDUCTION + lunch_count * LUNCH_REDUCTION + dinner_count * DINNER_REDUCTION
  end

  def result
    calculate_catering_costs + accommodations_per_diems - catering_costs_reduction
  end

end
