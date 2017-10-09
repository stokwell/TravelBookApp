class Trip < ApplicationRecord
  belongs_to :user
  has_one :billing, dependent: :destroy
  validates :trip_reason, :trip_start, :trip_end, presence: true

  after_create :billing_trip

  def billing_trip
    build_billing.billing_for_trip
  end

end
