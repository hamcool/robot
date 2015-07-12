require_relative 'robot'
require_relative 'table'

class RobotApplication
 def initialize
   @table = Table.new
   @robot = Robot.new
 end
 
 def robotPlaced?
    return @robot.isPlaced?
 end
 
 def getRobotPosition
    return @robot.reportPosition?
 end
end


app = RobotApplication.new

ARGF.each_with_index do |line, idx|
 # process commands.....
end

if !app.robotPlaced?
  puts "Robot not placed - check file for correct robot insturctions"
else
  puts "Output: " + app.getRobotPosition
end




