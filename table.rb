class Table
# grid table with x and y axis.
# row and columns start at 0
# e.g for a 3x3 table numbering would be as follows
#    0 1 2
#    _ _ _
# 2 |_ _ _|
# 1 |_ _ _|
# 0 |_ _ _|
  
  def initialize(width=4,height=4)
    # can be initialised to any size. Defaults to 5 X 5 (index starts at 0)
    @y_boundary = height
    @x_boundary = width
  end
  
  def validMove(start_x, start_y, direction, distance)
    if direction == "NORTH"
      return start_y + distance <= @y_boundary
    elsif direction == "SOUTH"
      return start_y - distance >= 0
    elsif direction == "EAST"
      return start_x + distance <= @x_boundary
    elsif direction == "WEST"
      return start_x - distance >= 0
    end
  end
  
  def check_y_boundary(y)
    return false if !@y_boundary
    return (y <= @y_boundary && y >= 0)
  end
  
  def check_x_boundary(x)
    return false if !@x_boundary
    return (x <= @x_boundary && x >= 0)
  end
end