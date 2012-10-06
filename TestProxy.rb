require 'faraday'
require 'cgi'

##
# Tests if the proxy server is working.
class TestProxy
  
  ##
  # constructor
  #
  # ==== Params
  # 
  # - +proxy_str+ string parameter having ip:port of the proxy server. e.g "127.0.0.1:80"
  def initialize proxy_str
    @ip, @port = proxy_str.split(":")
    @proxy_str = proxy_str
  end
  
  ##
  # creates new connection to google.com using +Faraday+ lib. Uses CGI::Cookie class
  # to parse the cookie returned in the response. It then checks for the presense of
  # "NID" cookie set by Google. If the cookie exists, proxy server is working just fine.
  #
  def test
    begin
      f = Faraday.new(:proxy => { :uri => "http://" + @proxy_str})
      response = f.get "http://www.google.com"
      @cookie = CGI::Cookie.parse(response.headers["set-cookie"])
      if(@cookie["NID"].empty?)
        puts ":(\n#{@proxy_str} is NOT working."
      else
        puts ":)\n#{@proxy_str} is working."
      end
    rescue
      puts ":(\nConnection to #{@proxy_str} timed out."
    end
  end
  
end
