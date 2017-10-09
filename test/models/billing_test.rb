require 'test_helper'

class BillingTest < ActiveSupport::TestCase

  test 'should create a billing for trip with proper accommodations per diems' do
    trip = create(:trip, night_count: 2)
    billing = trip.billing
    assert billing.night_count == 2 && billing.accommodations_per_diems == 40
  end

  test 'should create a billing for trip with no catering_costs' do
    trip = create(:trip, trip_start: '12/05/2017 12:00'.to_datetime, trip_end: '12/05/2017 15:00'.to_datetime )
    billing = trip.billing
    assert billing.catering_costs == 0
  end

  test 'should create a billing for half day trip' do
    trip = create(:trip, trip_start: '12/05/2017 8:00'.to_datetime, trip_end: '12/05/2017 20:00'.to_datetime )
    billing = trip.billing
    assert billing.catering_costs == 12
  end

  test 'should create a billing for many days trip with proper computations' do
    trip = create(:trip,
      trip_start: '12/05/2017 8:00'.to_datetime,
      trip_end: '15/05/2017 20:00'.to_datetime,
      breakfast_count: 1,
      lunch_count: 1,
      dinner_count: 2,
      night_count: 2
     )
    billing = trip.billing
    assert billing.catering_costs == 72
    assert billing.catering_costs_reduction == (1 * 24 * 0.2) + (1 * 24 * 0.4) + (2 * 24 * 0.4)
    assert billing.result == 72 + 40 - ((1 * 24 * 0.2) + (1 * 24 * 0.4) + (2 * 24 * 0.4))
  end

end
