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
          if search_term
            @search_results = ITuner.itunes.music.search(search_term)
          end
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
