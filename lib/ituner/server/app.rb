require 'haml'
require 'ituner'
require 'json'
require 'sinatra/base'
require 'sinatra/reloader'
require 'ituner/server/requests'

module ITuner
  module Server
    class App < Sinatra::Base

      set :app_file, __FILE__
      set :haml, :format => :html5

      configure(:development) do
        register Sinatra::Reloader
      end

      helpers do

        def search
          search_term = params["term"]
          return nil if search_term.to_s.empty?
          case search_term
          when /^album:(.*)/
            only = :albums
            name = $1
          when /^artist:(.*)/
            only = :artists
            name = $1
          when /^(?:track|song|name):(.*)/
            only = :songs
            name = $1
          else
            only = :all
            name = search_term
          end
          @search_results = ITuner.itunes.music.search(name, only)
        end

        def playing?
          ITuner.itunes.playing?
        end
        
        def keep_playing
          Requests.play_next unless playing? 
        end

      end

      get '/style.css' do
        scss :style
      end

      get '/' do
        keep_playing
        @current_track = ITuner.itunes.current_track
        @requests = Requests.all
        search
        haml :home
      end
      
      post "/request" do
        params["track_uids"].each do |track_uid|
          track = ITuner::Track.find_by_uid(Integer(track_uid))
          Requests.add_track(track)
        end
        redirect to("/")
      end

    end
  end
end
