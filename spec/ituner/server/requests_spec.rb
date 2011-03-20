require 'spec_helper'

describe ITuner::Server::Requests do

  before do
    ITuner::Server::Requests.clear
  end
  
  describe ".add_track" do
    
    before do
      @track = ITuner.itunes.music.search("Smells Like Teen Spirit").first
      ITuner::Server::Requests.add_track(@track)
    end
    
    it "adds a track" do
      request = ITuner::Server::Requests.first
      request.should_not be_nil
      request.should be_kind_of(ITuner::Server::Request)
      request.track.should be_kind_of(ITuner::Track)
      request.track.name.should == "Smells Like Teen Spirit"
    end
    
  end
  
end
