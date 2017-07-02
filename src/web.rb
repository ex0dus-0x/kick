require 'sinatra'

set :public_folder, File.dirname(__FILE__) + '../views'


get '/' do
   'Welcome to the byebye web interface!'
end