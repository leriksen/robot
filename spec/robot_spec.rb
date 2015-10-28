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
        # one example to prove unplaced robot still doesn't get methods 
        extra_robot = Robot.new
        expect(subject).to_not respond_to(:report)
        expect(extra_robot).to_not respond_to(:report)
        subject.place(0,0)
        expect(subject).to respond_to(:report)
        expect(extra_robot).to_not respond_to(:report)
      end
    end

    context "with a facing" do
      before(:each) do
        subject.place(0,0, :south)
      end

      it 'turns left correctly' do
        subject.left.left
        expect(subject.send :facing).to eql(:north)
      end
      it 'turns right correctly' do
        subject.right.right
        expect(subject.send :facing).to eql(:north)
      end
    end
  end

  context '.method_missing' do
    it 'raises exceptions for unknown commands' do
      expect{subject.fire_lasers}.to raise_exception(Robot::UnknownCommandError, /unknown command fire_lasers/)
    end

    it 'raises exceptions for commands for unplaced robots' do
      expect{subject.move}.to raise_exception(Robot::UnplacedError, /robot not yet placed/)
    end
  end

  context '.report' do
    it "returns the attributes for a user to create a report" do
      subject.place(0,0)
      expect(subject.report).to eql([0, 0, :north])
    end
  end

  context '.move' do
    it 'moves when it is safe' do
      subject.place(0,0)
      expect{subject.move}.to_not raise_exception
      expect(subject.report).to eql([0, 1, :north])
    end

    it 'raises an exception if moving is unsafe' do
      subject.place(0,0, :south)
      expect{subject.move}.to raise_exception(Robot::UnsafeMoveError, /facing edge at /)
      expect(subject.report).to eql([0, 0, :south])
    end
  end
end
