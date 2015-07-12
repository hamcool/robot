require 'minitest/autorun'
require_relative 'table'

class RobotTest < Minitest::Test

  def setup
    @table = Table.new
    @robot = Robot.new
  end

  def test_table_default_boundaries
    # check can move north if not going past edge
    assert @table.validMove(0,0,"N",1), "fail should be in bounds moving north"
    # check is out of bounds if move north over edge
    assert !@table.validMove(0,4,"N",1), "fail should be out of bounds moving north"
    # check can move west if not going past edge
    assert @table.validMove(1,0,"W",1), "fail should be in bounds moving west"
    # check can move north if not going past edge
    assert !@table.validMove(0,0,"W",1), "fail should be out of bounds moving west"
    # check can move south if not going past edge
    assert @table.validMove(0,1,"S",1), "fail should be in bounds moving south"
    # check is out of bounds if move south over edge
    assert !@table.validMove(0,0,"S",1), "fail should be out of bounds moving south"
    # check can move east if not going past edge
    assert @table.validMove(0,0,"E",1), "fail should be in bounds moving east"
    # check is out of bounds if move east past edge
    assert !@table.validMove(4,0,"E",1), "fail should be out of bounds moving east"
  end
  
  def test_robot
    #check robot not on table on initialisation
    assert !@robot.isPlaced?, "robot should not be isPlaced until it is placed"
    #place on table then check is placed
    @robot.placeOnTable(0,0,"N", @table)
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
  end
  
end