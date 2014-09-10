require 'rails_helper'

describe Plan do
  it { should validate_presence_of :name }
  it { should validate_presence_of :amount }
  it { should validate_presence_of :interval }
  it { should validate_presence_of :stripeid }
  it { should validate_presence_of :nonprofit_id }
  it { should validate_numericality_of :amount }
end



