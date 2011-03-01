require 'haml'
require 'ituner'
require 'json'
require 'sinatra'
require 'sinatra/reloader' if development?

require 'ituner/server/database'

set :app_file, __FILE__
set :haml, :format => :html5

get '/' do
  @current_track = ITuner.itunes.current_track
  haml :home
end

get '/search.json' do

  name = params["term"]
  @tracks = ITuner.itunes.music.search(name)

  @track_data = @tracks.map(&:name)

  content_type :json
  @track_data.to_json

end

get '/style.css' do
  scss :style
end

