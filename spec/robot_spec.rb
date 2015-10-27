require 'spec_helper'

describe Robot do
  context "#new" do
    it { is_expected.to be_a(described_class) }
  end
end