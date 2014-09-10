class Plan < ActiveRecord::Base
  belongs_to :nonprofit
  validates_numericality_of :amount
  validates :amount, :interval, :stripeid, :name, :nonprofit_id, presence: true
end
