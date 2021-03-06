class Robot
  NORTH = "NORTH"
  SOUTH = "SOUTH"
  EAST = "EAST"
  WEST = "WEST"

  def placeOnTable(x=0,y=0,facing=NORTH,table)
    # only allow placement if it is invalid.
    return false if !table
    return false if !table.check_x_boundary(x)
    return false if !table.check_y_boundary(y)
    return false if (facing != NORTH && facing != EAST && facing != SOUTH && facing != WEST)
    
    # default position is 0,0
    @table = table
    @x = x
    @y = y
    @facing = facing
  end
  
  def isPlaced?
    # table will only be set if robot has been placed.
    @table ? true : false
  end
  
  def reportPosition
    self.isPlaced? ? "#{@x},#{@y},#{@facing}" : "Robot not on table"
  end
  
  def turnRight
    return false if !isPlaced?
    
    if @facing == NORTH
      @facing = EAST
    elsif @facing == EAST
      @facing = SOUTH
    elsif @facing == SOUTH
      @facing = WEST
    elsif @facing == WEST
      @facing = NORTH
    end
  end
  
  def turnLeft
    return false if !isPlaced?
    
    if @facing == NORTH
      @facing = WEST
    elsif @facing == EAST
      @facing = NORTH
    elsif @facing == SOUTH
      @facing = EAST
    elsif @facing == WEST
      @facing = SOUTH
    end
  end
  
  def moveForward
    #ignore move if not placed or not a valid move
    return false if !isPlaced?
    return false if !@table.validMove(@x, @y, @facing, 1)
    # if pass checks then update position.
    if @facing == NORTH
      @y += 1
    elsif @facing == SOUTH
      @y -= 1
    elsif @facing == EAST
      @x += 1
    elsif @facing == WEST
      @x -= 1
    end
  end
  
end

