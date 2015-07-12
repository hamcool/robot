class RobotApplication
  def initialize
   @table = Table.new
   @robot = Robot.new
  end
  
  def robotPlaced?
    return @robot.isPlaced?
  end
  
  def getRobotPosition
    return @robot.reportPosition
  end
  
  def process_instruction(instruction)
    if instruction.upcase == "MOVE"
      @robot.moveForward
    elsif instruction.upcase == "LEFT"
      @robot.turnLeft
    elsif instruction.upcase == "RIGHT"
      @robot.turnRight
    elsif instruction.upcase == "REPORT"
      puts @robot.reportPosition
    elsif instruction[0,5].upcase == "PLACE"
      @robot.placeOnTable(instruction[6,1].to_i, instruction[8,1].to_i, instruction[10..-1], @table)
    end
  end
end






