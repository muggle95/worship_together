class User < ActiveRecord::Base
	validates :name, presence: true
	validates :email, presence: true
	validates :password, presence: true
	validates :name, uniqueness: true
	validates :email, uniqueness: true
	validates :name, length: {in: 2..15}
end
