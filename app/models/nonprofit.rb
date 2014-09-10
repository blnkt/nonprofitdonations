 class Nonprofit < ActiveRecord::Base
  # before_create :payment_details
  validates :name, :description, presence: true
end
