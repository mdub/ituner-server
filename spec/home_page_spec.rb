require "spec_helper"

describe ITuner::Server::App do

  before do
    @itunes = ITuner.itunes 
  end

  describe "/" do

    before do
      @track = @itunes.library.tracks["Freddie Freeloader"]
      @track.play
    end
    
    it "displays current track" do
      get "/"
      last_response.body.should include("Freddie Freeloader")
    end
  
  end

end