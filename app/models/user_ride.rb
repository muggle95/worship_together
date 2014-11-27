class UserRide < ActiveRecord::Base
  belongs_to :user
  belongs_to :ride
  
  validates :user, presence: true
  validates :ride, presence: true
end
