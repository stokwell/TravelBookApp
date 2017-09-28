class TripsController < ApplicationController
  before_action :require_login

  def index
  end

  def show
    @trip = Trip.find_by_id(params[:id])
    @billing = @trip.billing
  end

  def new
    @trip = Trip.new(params[:trip])
  end

  def create
    @trip = current_user.trips.create(trip_params)
    redirect_to root_path
  end

  def last_trips
    @trips = Trip.limit(7).order('id desc')
  end

  def months
    @months = Trip.all
      .map { |d| d.trip_start.to_date.strftime('%B %Y') if d.trip_start.present? }
      .uniq
      .sort_by { |m| m.to_date.month }
    render 'overview'
  end

  def trip_params
    params.require(:trip)
      .permit(:trip_reason, :trip_start, :trip_end, :trip_departure, :trip_arrival, :distance, :outlay, :notice,
        :night_count, :breakfast_count, :dinner_count, :lunch_count)
  end
end
