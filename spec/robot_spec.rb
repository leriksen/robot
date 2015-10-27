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

    context 'command method' do
      before(:each) do
        allow_any_instance_of(Table).to receive(:is_safe_place?).and_return(true)
      end

      it '"move" does not exist before robot placed' do
        expect(subject).to_not respond_to(:move)
        subject.place(0,0)
        expect(subject).to respond_to(:move)
      end

      it '"left" does not exist before robot placed' do
        expect(subject).to_not respond_to(:left)
        subject.place(0,0)
        expect(subject).to respond_to(:left)
      end

      it '"right" does not exist before robot placed' do
        expect(subject).to_not respond_to(:right)
        subject.place(0,0)
        expect(subject).to respond_to(:right)
      end

      it '"report" does not exist before robot placed' do
        expect(subject).to_not respond_to(:report)
        subject.place(0,0)
        expect(subject).to respond_to(:report)
      end

    end
  end
end