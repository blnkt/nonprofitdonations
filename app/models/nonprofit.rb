 class Nonprofit < ActiveRecord::Base
  # before_create :payment_details
  has_many :plans
  validates :name, :description, presence: true
end
