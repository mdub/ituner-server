require 'haml'
require 'ituner'
require 'json'
require 'sinatra/base'
require 'sinatra/reloader'
require 'ituner/server/database'

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

      end

      get '/style.css' do
        scss :style
      end

      get '/' do
        @current_track = ITuner.itunes.current_track
        search
        haml :home
      end

      # get '/search.json' do
      #   search
      #   @track_data = @tracks.map(&:name)
      #   content_type :json
      #   @track_data.to_json
      # end

    end
  end
end
