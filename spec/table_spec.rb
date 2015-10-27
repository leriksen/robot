require 'spec_helper'

describe Table do
  # it should take a height and a width, as not all tables are square
  subject {described_class.new(5,5)}

  context '#new' do
    it { is_expected.to be_a(described_class) }
  end  
end
