require 'spec_helper'

describe Table do
  # it should take a height and a width, as not all tables are square
  subject {described_class.new(5,5)}

  context '#new' do
    it { is_expected.to be_a(described_class) }

    it "only allows tables are 2-dimensional" do
      expect{described_class.new(0,0)}.to raise_exception(RuntimeError, /Table cannot have zero length or height/)
      expect{described_class.new(5,0)}.to raise_exception(RuntimeError, /Table cannot have zero length or height/)
      expect{described_class.new(0,5)}.to raise_exception(RuntimeError, /Table cannot have zero length or height/)
    end
  end

  context '.facing_edge?(x,y,facing)' do
    it { is_expected.to respond_to(:facing_edge?) }

    it "detects the southern edge" do
      expect(subject.facing_edge? 0, 0, :south).to be_truthy
      expect(subject.facing_edge? 1, 1, :south).to be_falsey
    end

    it "detects the northern edge" do
      expect(subject.facing_edge? 5, 5, :north).to be_truthy
      expect(subject.facing_edge? 1, 1, :north).to be_falsey
    end

    it "detects the western edge" do
      expect(subject.facing_edge? 0, 0, :west).to be_truthy
      expect(subject.facing_edge? 4, 4, :west).to be_falsey
    end

    it "detects the eastern edge" do
      expect(subject.facing_edge? 5, 5, :east).to be_truthy
      expect(subject.facing_edge? 4, 4, :east).to be_falsey
    end

    it "only accepts cardinal points" do
      expect{subject.facing_edge? 2, 2, :up}.to raise_exception(RuntimeError, /Unknown cardinal compass point/)
    end
  end
end
