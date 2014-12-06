class Church < ActiveRecord::Base
  belongs_to :user, inverse_of: :church_managed
  has_many :services, inverse_of: :church
  has_many :users, inverse_of: :church

  accepts_nested_attributes_for :services
  
  validates :user, presence: true
  validates :name, presence: true
 # validates :id, presence: true#, numericality: {greater_than_or_equal_to: 0}
  validates :web_site, presence: true
end
