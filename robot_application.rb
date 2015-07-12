require_relative 'robot'
require_relative 'table'
require_relative 'robot_controller'

app = RobotApplication.new

ARGF.each_with_index do |line, idx|
  # process commands.....
  app.process_instruction(line.chomp)
end

if !app.robotPlaced?
  puts "Robot not placed - check file has correct robot insturctions"
else
  puts "Robot finished moving"
end
