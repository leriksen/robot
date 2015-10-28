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

    elements = line.split(',')
    [elements.shift.to_sym, elements]
  end
end
