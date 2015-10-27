class Table

  def initialize(width, height)
    fail 'Table cannot have zero length or height' if width == 0 or height == 0
    @width  = width
    @height = height
  end

  # lets model that the table knows where its edges are and what way you're facing when looking over the edge

  def facing_edge?(x, y, facing)
    case facing
    when :east
      x == @width
    when :west
      x == 0
    when :north
      y == @height
    when :south
      y == 0
    else
      fail "Unknown cardinal compass point #{facing}"
    end 
  end

  # is this cartesian pair actually on our table ?

  def is_safe_place?(x, y)
    x.between?(0, @width) and y.between?(0, @height)
  end
end
