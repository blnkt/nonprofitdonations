require 'rails_helper'

describe Nonprofit do
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should have_many :plans }
end
