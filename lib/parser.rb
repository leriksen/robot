class Parser

  include Enumerable

  def initialize(file)
    @lines = file.readlines.map(&:chomp).map(&:strip).map(&:downcase)
  end

  def next
    process_line
  end

  def each
    loop do
      yield self.next
    end
  end

  private
  def process_line
    line = @lines.shift

    raise StopIteration unless line

    (command, args) = line.split(' ')
    [command.to_sym, args.nil? ? args : args.split(',')]
  end
end
