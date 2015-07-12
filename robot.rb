class Robot
  
  def placeOnTable(x=0,y=0,facing="N",table)
    # default position is 0,0
    @table = table
    @x = x
    @y = y
    @facing = facing
  end
  
  def isPlaced?
    @table ? true : false
  end
  
  def
    self.isPlaced? ? "#{@x},#{@y},#{direction}" : "Not Placed"
  end
  
  def direction
    if @facing == "N"
      return "NORTH"
    elsif @facing == "E"
      return "EAST"
    elsif @facing == "S"
      return "SOUTH"
    elsif @facing == "W"
      return "WEST"
    else
      return "Not Placed"
    end
    
  end
  
  def turnRight
    if @facing == "N"
      @facing = "E"
    elsif @facing == "E"
      @facing = "S"
    elsif @facing == "S"
      @facing = "W"
    elsif @facing == "W"
      @facing = "N"
    end
  end
  
  def turnLeft
    if @facing == "N"
      @facing = "W"
    elsif @facing == "E"
      @facing = "N"
    elsif @facing == "S"
      @facing = "E"
    elsif @facing == "W"
      @facing = "S"
    end
  end
  
  def moveForward
    return false if !isPlaced?
    return false if !@table.validMove(@x, @y, @facing, 1)
    # if pass checks then update position.
    if @facing == "N"
      @y += 1
    elsif @facing == "S"
      @y -= 1
    elsif @facing == "E"
      @x += 1
    elsif @facing == "W"
      @x -= 1
    end
  end
  
end

