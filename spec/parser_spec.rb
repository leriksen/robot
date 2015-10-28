require 'spec_helper'

describe Parser do
  let(:file) {
    StringIO.new <<-EOS
      PLACE,0,0,north
      MOVE
      REPORT
    EOS
  }

  subject {described_class.new file}
  context 'reading input' do
    it 'can iterate' do
      expect(subject).to respond_to(:each)

      list = []
      subject.each do |command, args|
        list << command
      end
      expect(list.length).to eql(3)
    end

    it 'can map' do
      result = subject.map {|command, args|
        if command == :place
          [command, [args[0].to_i, args[1].to_i, args[2].to_sym]]
        else
          [command]
        end
      }
      expect(result).to eql([[:place, [0, 0, :north]], [:move],  [:report]])
    end
  end
end
