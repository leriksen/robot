class Parser

  include Enumerable

  def initialize(io)
    # returns raw enumerator
    @io = io.each
  end

  def each
    loop do
      yield process_line(io.next)
    end
  end

  private
  def process_line(line)
    if line
      (command, args) = line.downcase.strip.split(' ')
      [command.to_sym, args.nil? ? args : args.split(',')]
    end
  end

   attr_reader :io
end
