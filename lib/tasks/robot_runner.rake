$LOAD_PATH << 'lib'

require 'robot'
require 'parser'

desc "Run the robot, safely"
task :robot_runner, [:file] do |task, args|
  robot = Robot.new
  parser = Parser.new(File.open(args[:file], 'r'))

  # we can map the commands the parser reads here, because we know what kind of robot we're dealing with
  # we dont want to embed robot-knowledge in the parser
  parser.map {|command, args|
    if command == :place
      [command, [args[0].to_i, args[1].to_i, args[2].to_sym]]
    else
      [command]
    end
  }.each {|command, args|
    begin
      result = robot.send(command, *args)
    rescue => e
      puts e.message
    else
      if command == :report
        puts "#{result[0]},#{result[1]},#{result[2].upcase}"
      end
    end
  }
end