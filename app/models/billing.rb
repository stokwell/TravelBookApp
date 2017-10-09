class Billing < ApplicationRecord
  ADDITION_FOR_WHOLE_DAY = 24
  ADDITION_FOR_HALF_DAY = 12
  ADDITION_FOR_NIGHT = 20

  BREAKFAST_REDUCTION = ADDITION_FOR_WHOLE_DAY * 0.2
  LUNCH_REDUCTION = ADDITION_FOR_WHOLE_DAY * 0.4
  DINNER_REDUCTION = ADDITION_FOR_WHOLE_DAY * 0.4
  belongs_to :trip

  def billing_for_trip
     update_attributes(
      whole_days_count: full_payed_days_count,
      half_days_count: half_payed_days_count,

      night_count: trip.night_count,
      addition_for_night: ADDITION_FOR_NIGHT,
      accommodations_per_diems: accommodations_per_diems,

      breakfast_count: trip.breakfast_count,
      lunch_count: trip.lunch_count,
      dinner_count: trip.dinner_count,

      breakfast_reduction: BREAKFAST_REDUCTION,
      lunch_reduction: LUNCH_REDUCTION,
      dinner_reduction: DINNER_REDUCTION,

      addition_for_half_day: ADDITION_FOR_HALF_DAY,
      addition_for_whole_day: ADDITION_FOR_WHOLE_DAY,

      catering_costs: calculate_catering_costs,
      catering_costs_reduction: catering_costs_reduction,
      result: result
    )
  end

  def accommodations_per_diems
    trip.night_count * ADDITION_FOR_NIGHT
  end

  def calculate_catering_costs
    trip.trip_start.to_date == trip.trip_end.to_date ? calculate_costs_for_half_day_or_nothing : calculate_costs_for_many_days_trip
  end

  def calculate_costs_for_half_day_or_nothing
    trip.trip_end.hour - trip.trip_start.hour > 8 ? ADDITION_FOR_HALF_DAY : 0
  end

  def full_payed_days_count
    full_payed_days = (trip.trip_start.to_date...trip.trip_end.to_date).to_a.tap { |arr| arr.delete(trip.trip_start.to_date) }.count
  end

  def half_payed_days_count_for_one_day_trip
    trip.trip_start == trip.trip_end && trip.trip_end.hour - trip.trip_start.hour > 8 ? 1 : 0
  end

  def half_payed_days_count
    trip.trip_start.to_date == trip.trip_end.to_date ? half_payed_days_count_for_one_day_trip : 2
  end

  def calculate_costs_for_many_days_trip
    costs = full_payed_days_count * ADDITION_FOR_WHOLE_DAY + 2 * ADDITION_FOR_HALF_DAY
  end

  def catering_costs_reduction
    trip.breakfast_count * BREAKFAST_REDUCTION + trip.lunch_count * LUNCH_REDUCTION + trip.dinner_count * DINNER_REDUCTION
  end

  def result
    calculate_catering_costs + accommodations_per_diems - catering_costs_reduction
  end


end
