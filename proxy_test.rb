require_relative 'TestProxy'
puts "Checking #{ARGV[0]} .."
TestProxy.new(ARGV[0]).test