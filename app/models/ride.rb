class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :service
  has_many :user_rides
  has_many :users, through: :user_rides
  
  validates :user, presence: true
  validates :service, presence: true
  validates :number_of_seats, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :seats_available, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :meeting_location, presence: true
  validates :vehicle, presence: true
  validates :date, presence: true
  validates :leave_time, presence: true
  validates :return_time, presence: true
  
  #validate :past_leave_time, on: :create
  #def past_leave_time
  #  if(leave_time)
  #    errors.add(:leave_time, "the leave time has already passed") unless (Date.today || leave_time > Time.now)
  #  end
  #end
  validate :ride_previous_day, on: :create
  def ride_previous_day
    if(date)
      errors.add(:date, "the ride is scheduled for a day in the past") unless (date >= Date.today)
    end
  end
  
  validate :return_before_leaving
  def return_before_leaving
    if(return_time && leave_time)
      errors.add(:return_time, "the ride cannot leave after it returns") unless (return_time > leave_time)
    end
  end
  
  validate :enough_seats
  def enough_seats
    if(number_of_seats && seats_available)
      errors.add(:seats_available,"") unless (number_of_seats>=seats_available)
    end
  end
  
  validate :in_future, on: :create
  def in_future
    if(date)
      errors.add(:date,"business rules require the ride to be created at least a day before it happens") unless (date > Date.today())
    end
  end
  
end
