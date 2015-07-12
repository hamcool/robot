# Toy Robot Simulator

Call robot_application.rb to run simulator. 

Robot Commands in file format can be passed into the application as an argument when running the application.  
E.g. $ ruby robot_application.rb < testdata1.txt

Commands can also be inputed directly to command line after the program has started, but running the program with no file. 
initialisation.   
E.g. $ ruby robot_application.rb
Then enter commands followed by 'enter' as per file format (PLACE 1,1,NORTH, MOVE, etc)
An additional command 'EXIT' has been added to assist when using the command line. This will exit the program.

To test the application use:
$ ruby robot_test.rb

