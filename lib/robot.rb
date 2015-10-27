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
    end
  end
end