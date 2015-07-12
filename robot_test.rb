require 'minitest/autorun'
require_relative 'robot'
require_relative 'table'
require_relative 'robot_controller'



class RobotTest < Minitest::Test
  NORTH = "NORTH"
  SOUTH = "SOUTH"
  EAST = "EAST"
  WEST = "WEST"

  def setup
    @table = Table.new
    @robot = Robot.new
    @robot_app = RobotApplication.new
  end

  def test_table_default_boundaries
    # check can move north if not going past edge
    assert @table.validMove(0,0,NORTH,1), "fail should be in bounds moving north"
    # check is out of bounds if move north over edge
    assert !@table.validMove(0,4,NORTH,1), "fail should be out of bounds moving north"
    # check can move west if not going past edge
    assert @table.validMove(1,0,WEST,1), "fail should be in bounds moving west"
    # check can move north if not going past edge
    assert !@table.validMove(0,0,WEST,1), "fail should be out of bounds moving west"
    # check can move south if not going past edge
    assert @table.validMove(0,1,SOUTH,1), "fail should be in bounds moving south"
    # check is out of bounds if move south over edge
    assert !@table.validMove(0,0,SOUTH,1), "fail should be out of bounds moving south"
    # check can move east if not going past edge
    assert @table.validMove(0,0,EAST,1), "fail should be in bounds moving east"
    # check is out of bounds if move east past edge
    assert !@table.validMove(4,0,EAST,1), "fail should be out of bounds moving east"
  end
  
  def test_robot
    #check robot not on table on initialisation
    assert !@robot.isPlaced?, "robot should not be isPlaced until it is placed"
    #place on table then check is placed
    @robot.placeOnTable(0,0,NORTH, @table)
    assert @robot.isPlaced?, "robot should isPlaced after being placed"
    # Check position
    assert (@robot.reportPosition == "0,0,NORTH"), "robot position does not equal where it was placed"
    
    # check some moves
    assert @robot.moveForward, "move forward not ok after being positioned to arrive at 0,1"
    assert (@robot.reportPosition == "0,1,NORTH"), "robot move position does not equal where it was moved to"
    # check turn right
    @robot.turnRight
    assert (@robot.reportPosition == "0,1,EAST"), "robot turn right position does not equal where it was turned to"
    # check turn left
    @robot.turnLeft
    assert (@robot.reportPosition == "0,1,NORTH"), "robot turn left position does not equal where it was turned to"
    
    #check bounds... move to end of table
    assert @robot.moveForward, "move forward not ok after being positioned to arrive at 0,2"
    assert @robot.moveForward, "move forward not ok after being positioned to arrive at 0,3"
    assert @robot.moveForward, "move forward not ok after being positioned to arrive at 0,4"
    
    # next move should fail.
    assert !@robot.moveForward, "move does not fail when moving out of bounds - moving from 0,4"
    
    # position should now be 0,4
    assert (@robot.reportPosition == "0,4,NORTH"), "robot position not the same after failed move."
    
    #check all facing positions
    @robot.turnRight
    assert (@robot.reportPosition == "0,4,EAST"), "robot turn right position does not equal EAST"
    @robot.turnRight
    assert (@robot.reportPosition == "0,4,SOUTH"), "robot turn right position does not equal SOUTH"
    @robot.turnRight
    assert (@robot.reportPosition == "0,4,WEST"), "robot turn right position does not equal WEST"
    @robot.turnRight
    assert (@robot.reportPosition == "0,4,NORTH"), "robot turn right position does not equal NORTH"
    
    
    #check all facing positions
    @robot.turnLeft
    assert (@robot.reportPosition == "0,4,WEST"), "robot turn left position does not equal WEST"
    @robot.turnLeft
    assert (@robot.reportPosition == "0,4,SOUTH"), "robot turn left position does not equal SOUTH"
    @robot.turnLeft
    assert (@robot.reportPosition == "0,4,EAST"), "robot turn left position does not equal EAST"
    @robot.turnLeft
    assert (@robot.reportPosition == "0,4,NORTH"), "robot turn left position does not equal NORTH"
    
  end
  
  def test_robot_placements
    @robot = Robot.new
    #place on table without co-ordinates and then check position is bottom of table
    @robot.placeOnTable(@table)
    assert (@robot.reportPosition == "0,0,NORTH"), "robot default position does not equal defaults"
    
    #place on table with invalid co-ordinates and then if placed
    @robot = Robot.new
    @robot.placeOnTable(5,5,NORTH,@table)
    assert !@robot.isPlaced?, "robot should not be isPlaced with invalid co-ordinates"
    
    #place on table with invalid co-ordinates and then if placed
    @robot = Robot.new
    @robot.placeOnTable(0,0,"XXXX",@table)
    assert !@robot.isPlaced?, "robot should not be isPlaced with invalid direction"
  end
  
  def test_application
    assert !@robot_app.robotPlaced?, "Robot should not be placed prior to instructions being read"
    # simulate file insturction read...
    array = [ "PLACE 1,2,EAST",
              "MOVE",
              "MOVE",
              "LEFT",
              "MOVE",
              "REPORT"]
              
    array.each_with_index do |line, idx|
      @robot_app.process_instruction(line)
    end
    assert (@robot_app.getRobotPosition == "3,3,NORTH"), "robot position not correct after test application run"
    
    #check invalid placement, and that subsequent moves ignored
    @robot_app = RobotApplication.new
    array = [ "PLACE 5,5,EAST", "MOVE", "LEFT", "RIGHT", "REPORT"]
  
    array.each_with_index do |line, idx|
      assert !@robot_app.process_instruction(line), "process insturction should be ignored when robot not placed"
    end
    assert !@robot_app.robotPlaced?, "Robot should not be placed after invalid placement"
  end
end