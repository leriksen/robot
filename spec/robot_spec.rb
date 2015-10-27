require 'spec_helper'

describe Robot do
  context "#new" do
    it { is_expected.to be_a(described_class) }
  end

  context '.place' do
    it { is_expected.to respond_to(:place) }

    it "allows us to place a robot in a safe place on the table" do
      expect_any_instance_of(Table).to receive(:is_safe_place?).and_return(true)
      expect(subject.place 0, 0).to be_truthy
    end

    it "does not allow us to place a robot off the table" do
      expect_any_instance_of(Table).to receive(:is_safe_place?).and_return(false)
      expect(subject.place 9, 9).to be_falsey
    end
  end
end