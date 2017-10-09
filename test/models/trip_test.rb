require 'test_helper'

class TripTest < ActiveSupport::TestCase
  def setup
    @trip = trips(:one)
  end

  test 'valid trip' do
    assert @trip.valid?
  end

  test 'invalid trip without trip reason' do
    @trip.trip_reason = nil
    refute @trip.valid?
    assert_not_nil @trip.errors[:trip_reason]
  end

  test 'invalid trip without trip start' do
    @trip.trip_start = nil
    refute @trip.valid?
    assert_not_nil @trip.errors[:trip_start]

  end

  test 'invalid trip without trip end' do
    @trip.trip_end = nil
    refute @trip.valid?
    assert_not_nil @trip.errors[:trip_end]
  end

  test 'should create a billing after create trip' do
    assert_nil @trip.billing
    billing = @trip.build_billing
    assert_not_nil @trip.billing
  end

 end
