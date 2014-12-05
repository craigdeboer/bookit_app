class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookable, polymorphic: true

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user_id, presence: true
  validates :bookable_type, presence: true
  validates :bookable_id, presence: true
end
