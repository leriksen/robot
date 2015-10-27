class Robot

  class UnplacedError       < StandardError; end
  class UnknownCommandError < StandardError; end
  class BadFacingError      < StandardError; end

  FACING = %i(north east south west)

  # an opportunity to show that this default eliminates the need for a 'subject' declaration
  # in the matching spec
  def initialize(table=Table.new(5,5))
    @table = table # again, no accessor, we dont know if we need to expose this yet.
  end

  def place(x, y, facing)
    unless FACING.include? facing
      raise BadFacingError, "facing must be one of (#{FACING})"
    end

    if @table.is_safe_place?(x, y)
      @x = x
      @y = y
      @facing = facing

      # this specific robot gets these methods now,
      # other unplaced robots do not
      def self.move
      end

      def self.left
        FACING.unshift FACING.pop
      end

      def self.right
        FACING.push FACING.shift
      end

      def self.report
      end
    end
  end

  def method_missing(name, *args, &block)
    if valid_command?(name)
      raise UnplacedError, "robot not yet placed"
    else
      raise UnknownCommandError, "unknown command #{name}"
    end
  end

  private
  def valid_command?(name)
    %i(move left right report).include? name
  end
end