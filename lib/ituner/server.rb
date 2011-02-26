require 'sinatra'
require "sinatra/reloader" if development?

require 'haml'
set :haml, :format => :html5

require 'ituner'

set :views, File.dirname(__FILE__) + '/server/views'

get '/' do
  @tracks = ITuner.itunes.music.search("sex", :songs)
  haml :index
end
