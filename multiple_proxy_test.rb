require_relative 'TestProxy'

##
# Accepts input from text file
file = File.new(ARGV[0],"r")
proxy_list = Array.new

while(p = file.gets)
  proxy_list.push p.chomp
end

proxy_list.each do |proxy|
  TestProxy.new(proxy).test
end
