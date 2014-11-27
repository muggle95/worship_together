class User < ActiveRecord::Base
    has_many :rides_provided, class_name: 'Ride', foreign_key: 'user_id'
    has_many :user_rides
    has_many :rides, through: :user_rides

    has_one :church
# if the church profile manager doesn't attend that church, use:
#    has_one :church_managed, class_name: 'Church', foreign_key: 'user_id'

    has_secure_password

   validates :name, presence: true, length: {minimum:1}, length: {maximum:50}
   validates :email,
	   presence: true,
	   format: { with: /\A         # begin of input
		   [-\w+.]+   # dash, wordy, plus, or dot characters
	     @          # required at sign
	     [-a-z\d.]+ # dash, letter, digit, or dot chars
	     \z         # end of input
	     /xi }
  validates :password, presence: true, length: {minimum: 6},
  format: {with: /[\w-+.\?]+/}
  validates :ride, presence: true
  validates :admin, presence:true
end
