require 'haml'
require 'ituner'
require 'sinatra'
require 'sinatra/reloader' if development?

set :app_file, __FILE__
set :haml, :format => :html5

get '/' do
  @tracks = ITuner.itunes.music.search("sex", :songs)
  haml :home
end

get '/search' do
  name = params["q"]
  @tracks = ITuner.itunes.music.search(name)
  haml :home
end
