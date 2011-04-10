# encoding: UTF-8

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
        with_tag("h1", :text => /Freddie Freeloader/)
        with_tag("h2", :text => /by Miles Davis/)
        with_tag("p", :text => /Kind Of Blue/)
      end
    end

    it "supports searching" do
      page.body.should have_tag("#search form") do
        with_tag("input", :with => {:name => "term"})
      end
    end

  end

  describe "track search" do

    before do
      visit "/"
      within("#search") do
        fill_in("term", :with => "Blue")
        click_button("Search")
      end
    end

    it "displays the matches" do
      page.body.should have_tag("#search .results") do
        with_tag("ul li", :text => /Blue/, :minimum => 5)
      end
    end

  end

  describe "track request" do

    before do
      visit "/"
      within("#search") do
        fill_in("term", :with => "Kind Of Blue")
        click_button("Search")
      end
      within(".results") do
        first_track = page.find("li")
        @selected_track_name = first_track.find(".name").text
      end
      click_button("Request")
    end

    it "adds it to the requests" do
      within("#requests") do
        page.should have_content(@selected_track_name)
      end
    end

    it "retains the search term" do
      within("#search") do
        find_field("term").value.should == "Kind Of Blue"
      end
    end

    it "ensures that something is playing" do
      ITuner.itunes.should be_playing
    end

  end

  describe "the kill button" do

    before do
      ITuner::Server::Requests.add_first_track_matching("Freddie Freeloader")
      ITuner::Server::Requests.add_first_track_matching("So What")
    end

    it "stops the current song and starts the next one" do
      visit "/"
      page.body.should have_tag("#current-track h1", :text => /Freddie Freeloader/)
      pending do
        within("#current-track") do
          click_button("Kill")
        end
        page.body.should have_tag("#current-track h1", :text => /So What/)
      end
    end

  end

end
