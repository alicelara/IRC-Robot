require "socket"

server = "chat.freenode.net"	#define server to connect
port = "6667"
@nick = "CopyCat" #define NICKNAME HERE
@channel = "#bitmaker" #define Channel to connect
@prefix = "PRIVMSG #{@channel} :" #msg channel chat


# opens a new socket with the correct port and server
@irc_server = TCPSocket.open(server, port)
@irc_server.puts "USER CopyCat 0 * Testing"
@irc_server.puts "NICK #{@nick}"
@irc_server.puts "JOIN #{@channel}"
# @irc_server.puts "#{@prefix} " # use this if I want to say something in the channel

def msg_to_server(msg)
	@irc_server.puts msg
end

def simple(msg)
	a = msg.partition(@prefix)
	return a[2]
end

def search_users_input(msg)
	if msg.include? "#{@nick}: Mute"
		msg_to_server("#{@prefix}Muted")
		while true
			msg = @irc_server.gets
  			puts msg
  			break if msg.include?("#{@nick}: Run")
  		end
		msg_to_server("#{@prefix}YOLOGETWRKD")
	elsif msg.include? "#{@prefix}"
		b = simple(msg)
		@irc_server.puts "#{@prefix}#{b}"
	end	
end

until @irc_server.eof? do
  msg = @irc_server.gets
  puts msg
  puts search_users_input(msg)
		# @irc_server.puts "#{@prefix} #{msg}"
end



