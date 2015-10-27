class Robot

  # an opportunity to show that this default eliminates the need for a 'subject' declaration
  # in the matching spec
  def initialize(table=Table.new(5,5))
    @table = table # again, no accessor, we dont know if we need to expose this yet.
  end

  def place(x, y)
    if @table.is_safe_place?(x, y)
      @x = x
      @y = y

      # this specific robot gets these methods now,
      # other unplaced robots do not
      def self.move
      end

      def self.left
      end

      def self.right
      end

      def self.report
      end
    end
  end

  def method_missing(name, *args, &block)
    puts valid_command?(name.downcase) ? \
     "robot not yet placed - ignoring" : \
     "unknown command #{name}"
  end

  private
  def valid_command?(name)
    (%w(move left right report) & [name]).any?
  end
end