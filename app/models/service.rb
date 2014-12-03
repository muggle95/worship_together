class Service < ActiveRecord::Base
  belongs_to :church, inverse_of: :services
  has_many :rides

  validates :church, presence: true
  validates :start_time, presence: true
  validates :finish_time, presence: true
  validates :day_of_week, presence: true#, inclusion: {in: (Sunday Monday Tuesday Wednesday Thursday Friday Saturday Sun Mon Tue Tues Wed Thu Thur Thurs Fri Sat Su M T W R F Sa)}
  validates :location, presence: true
end
