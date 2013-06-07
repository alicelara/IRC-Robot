require "socket"

server = "chat.freenode.net"
port = "6667"
nick = "AliceBot"
@channel = "#alicebot"
@prefix = "PRIVMSG #{@channel} :"
# greeting = ["hello", "hi", "hola", "yo"]

# opens a new socket with the correct port and server
@irc_server = TCPSocket.open(server, port)

@irc_server.puts "USER AliceBot 0 * Testing"
@irc_server.puts "NICK #{nick}"
@irc_server.puts "JOIN #{@channel}"
# @irc_server.puts "#{@prefix} " # use this if I want to say something in the channel

def simple(msg)
	a = msg.partition(@prefix)
	return a[2]
end


def search_users_input(msg)
	if msg.include? "#{@prefix}"
		b = simple(msg)
		@irc_server.puts "#{@prefix}#{b}"
	end	
end

until @irc_server.eof? do
  msg = @irc_server.gets
  puts msg
  puts search_users_input(	msg)
  # @irc_server.puts "#{@prefix} #{msg}"
end



