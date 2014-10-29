class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.references :user, index: true
      t.references :bookable, polymorphic: true

      t.timestamps
    end
  end
end
