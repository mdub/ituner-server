require "spec_helper"

describe ITuner::Server::App, :type => :acceptance do

  before do
    @itunes = ITuner.itunes 
  end

  describe "home-page" do

    before do
      @track = @itunes.library.tracks["Freddie Freeloader"]
      @track.play
      visit "/"
    end

    it "displays current track" do
      page.body.should have_tag("#current-track") do
        with_tag("h1", :text => "Now playing")
        with_tag("p", :text => /Freddie Freeloader/)
      end
    end

    it "supports searching" do
      page.body.should have_tag("#search form") do
        with_tag("input", :with => {:name => "term"})
      end
    end

  end

  describe "when I search for a track" do

    before do
      visit "/"
      within("#search") do
        fill_in("term", :with => "Blue")
        click_button("Search")
      end
    end

    it "displays the matches" do
      page.body.should have_tag("#search .results") do
        with_tag("ul", :text => /Blue/, :minimum => 5)
      end
    end

  end

  describe "when I request a track" do

    before do
      visit "/"
      within("#search") do
        fill_in("term", :with => "Blue")
        click_button("Search")
      end
      within(".results") do
        first_track = page.find("li")
        first_track.find("input[type='checkbox']").set(true)
        @selected_track_name = first_track.find(".name").text
      end
      click_button("Request")
    end

    it "adds it to the requests" do
      within("#requests") do
        page.should have_content(@selected_track_name)
      end
    end

    it "ensures that something is playing" do
      ITuner.itunes.should be_playing
    end

  end

end
