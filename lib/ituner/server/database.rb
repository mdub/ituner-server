require 'fileutils'
require 'sequel'

module ITuner
  module Server
      
    def self.create_db
      db = Sequel.sqlite
      db.create_table(:requests) do
        primary_key :id
        integer :track_id
      end
      db
    end
    
    DB = create_db
      
  end
end