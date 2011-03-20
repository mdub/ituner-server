require 'fileutils'
require 'sequel'

module ITuner
  module Server

    DB = Sequel.sqlite.tap do |db|
      db.create_table(:requests) do
        primary_key :id
        integer :track_uid
      end
    end
      
    class Request < Sequel::Model(DB)
      
      class << self
        
        def clear
          dataset.delete
        end
        
        def add_track(track)
          create(:track_uid => track.uid)
        end
        
        def play_next
          next_request = first
          if next_request
            next_request.track.play
            next_request.delete
          end
        end
        
      end
      
      def track
        ITuner::Track.find_by_uid(track_uid)
      end
      
    end

    Requests = Request

  end
end