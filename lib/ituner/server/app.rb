require 'haml'
require 'ituner'
require 'sinatra'
require 'sinatra/reloader' if development?

require 'ituner/server/database'

set :app_file, __FILE__
set :haml, :format => :html5

get '/' do
  @current_track = ITuner.itunes.current_track
  haml :home
end

get '/search' do
  name = params["q"]
  @tracks = ITuner.itunes.music.search(name)
  haml :home
end
