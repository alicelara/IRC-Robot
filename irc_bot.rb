require "socket"
require 'ruby-debug'

default_server = "chat.freenode.net"  #define server to connect
port = "6667"
@default_nick = "CopyCat" #define NICKNAME HERE
@default_channel = "#bitmaker" #define Channel to connect
@prefix = "PRIVMSG #{@channel} :" #msg channel chat

puts "Welcome to The CopyCat Bot \n"
puts "Please enter the Server you with to connect to.\n Default:" + default_server

server = gets.chomp 
server = server ? default_server : server

puts "You have chosen " + server + "as your server of choice\n"
puts "Channel? Default: " + @default_channel

@channel = gets.chomp 
@channel = @channel ? @default_channel  : @channel

puts "Channel chosen: " + @channel + "\n"
puts "Please choose your nickname.\n Default: "+ @default_nick

@nick = gets.chomp
@nick = @nick ? @default_nick : @nick

puts "Nickname: "+ @nick

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