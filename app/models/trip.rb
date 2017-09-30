class Trip < ApplicationRecord
  belongs_to :user
  has_one :billing, dependent: :destroy
  validates_presence_of :trip_reason, :trip_start, :trip_end

  after_create :create_billing_for_trip

  def create_billing_for_trip
    Billing.new.create_billing
  end

end
