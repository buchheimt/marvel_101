require "spec_helper"

RSpec.describe "Marvel101::Scraper" do

  describe "#initialize" do
    it "Initializes a Scraper with a topic"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      new_scrape = Marvel101::Scraper.new(new_team)
      expect(new_scrape.topic).to eq(new_team)
    end
  end

  describe "#scrape_list" do
    it "sets topics to an array of teams when passed the team page url" do
      new_list = Marvel101::List.new("Popular Teams", "fixtures/teams.html")
      Marvel101::Scraper.new(new_list).scrape_list
      expect(new_list.items[0].is_a?(Marvel101::Team)).to eq(true)
    end

    it "properly instantiates new teams" do
      new_list = Marvel101::List.new("Popular Teams", "fixtures/teams.html")
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      Marvel101::Scraper.new(new_list).scrape_list
      expect(new_list.items[0].description).to eq(new_team.description)
    end

    it "sets topics to an array of characters when passed a character url" do
      new_list = Marvel101::List.new("Popular Heroes", "fixtures/heroes.html")
      Marvel101::Scraper.new(new_list).scrape_list
      expect(new_list.items[0].is_a?(Marvel101::Character)).to eq(true)
    end

    it "properly instantiates new characters" do
      new_list = Marvel101::List.new("Popular Heroes", "fixtures/heroes.html")
      new_character = Marvel101::Character.new("Spider-Man", "fixtures/heroes.html")
      Marvel101::Scraper.new(new_list).scrape_list
      expect(new_list.items[0].description).to eq(new_character.description)
    end
  end

  describe '#scrape_topic' do
    it "retrieves a description for a team if applicable" do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      Marvel101::Scraper.new(new_team).scrape_topic
      description = "Earth's Mightiest Heroes joined forces to take on threats that were too big for any one hero to tackle. With a roster that has included Captain America, Iron Man, Ant-Man, Hulk, Thor, Wasp and dozens more over the years, the Avengers have come to be regarded as Earth's No. 1 team."
      expect(new_team.description).to eq(description)
    end

    it "handles no description for a team" do
      new_team = Marvel101::Team.new("Defenders", "fixtures/defenders.html")
      Marvel101::Scraper.new(new_team).scrape_topic
      expect(new_team.description).to eq(nil)
    end

    it "returns an array of characters when possible" do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      Marvel101::Scraper.new(new_team).scrape_topic
      expect(new_team.members[0].name).to eq("Black Panther")
    end

    it "properly instantiates new characters" do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      Marvel101::Scraper.new(new_team).scrape_topic
      expect(new_team.members[0].is_a?(Marvel101::Character)).to eq(true)
    end

    it "handles no member info" do
      new_team = Marvel101::Team.new("Defenders", "fixtures/defenders.html")
      Marvel101::Scraper.new(new_team).scrape_topic
      expect(new_team.members.size).to eq(0)
    end

    it "retrieves a marvel 101 link for a team if applicable"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      Marvel101::Scraper.new(new_team).scrape_topic
      expect(new_team.url_101).to eq("https://www.youtube.com/watch?v=DLy08aZx5PQ")
    end

    it "retrieves a marvel wiki link for a team if applicable"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      Marvel101::Scraper.new(new_team).scrape_topic
      expect(new_team.url_wiki).to eq("http://marvel.com/universe/Avengers")
    end

    it "handles no marvel wiki url for a team" do
      new_team = Marvel101::Team.new("Inhumans", "fixtures/inhumans.html")
      Marvel101::Scraper.new(new_team).scrape_topic
      expect(new_team.url_wiki).to eq(nil)
    end

    it "handles no marvel 101 url for a team" do
      new_team = Marvel101::Team.new("Defenders", "fixtures/defenders.html")
      Marvel101::Scraper.new(new_team).scrape_topic
      expect(new_team.url_101).to eq(nil)
    end

    it "retrieves a description for a character if applicable" do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      Marvel101::Scraper.new(new_char).scrape_topic
      description = "As the Norse God of thunder and lightning, Thor wields one of the greatest weapons ever made, the enchanted hammer Mjolnir. While others have described Thor as an over-muscled, oafish imbecile, he's quite smart and compassionate.  He's self-assured, and he would never, ever stop fighting for a worthwhile cause."
      expect(new_char.description).to eq(description)
    end

    it "handles no description for a character" do
      new_char = Marvel101::Character.new("Gambit", "fixtures/gambit.html")
      Marvel101::Scraper.new(new_char).scrape_topic
      expect(new_char.description).to eq(nil)
    end

    it "retrieves a marvel 101 link for a character if applicable"  do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      Marvel101::Scraper.new(new_char).scrape_topic
      expect(new_char.url_101).to eq("https://www.youtube.com/watch?v=ZfSBdW6vblc")
    end

    it "retrieves a marvel wiki link for a character if applicable"  do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      Marvel101::Scraper.new(new_char).scrape_topic
      expect(new_char.url_wiki).to eq("http://marvel.com/universe/Thor_(Thor_Odinson)")
    end

    it "handles no marvel wiki url for a character" do
      new_char = Marvel101::Character.new("Gambit", "fixtures/gambit.html")
      Marvel101::Scraper.new(new_char).scrape_topic
      expect(new_char.url_wiki).to eq(nil)
    end

    it "handles no marvel 101 url for a character" do
      new_char = Marvel101::Character.new("Gambit", "fixtures/gambit.html")
      Marvel101::Scraper.new(new_char).scrape_topic
      expect(new_char.url_101).to eq(nil)
    end

    it "retrieves info for mass assignment" do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      Marvel101::Scraper.new(new_char).scrape_topic
      expect(new_char.real_name).to eq("Thor Odinson")
    end

    it "handles missing mass assignment info" do
      new_char = Marvel101::Character.new("Nova", "fixtures/nova.html")
      Marvel101::Scraper.new(new_char).scrape_topic
      expect(new_char.real_name).to eq(nil)
    end
  end

  describe '#description_scrape' do
    it "returns the correctly formatted string for teams" do
      scraper = Marvel101::Scraper.new("")
      scraper.doc = Nokogiri::HTML(open("fixtures/avengers.html"))
      result = scraper.description_scrape
      description = "Earth's Mightiest Heroes joined forces to take on threats that were too big for any one hero to tackle. With a roster that has included Captain America, Iron Man, Ant-Man, Hulk, Thor, Wasp and dozens more over the years, the Avengers have come to be regarded as Earth's No. 1 team."
      expect(result).to eq(description)
    end

    it "returns the correctly formatted string for characters" do
      scraper = Marvel101::Scraper.new("")
      scraper.doc = Nokogiri::HTML(open("fixtures/thor.html"))
      result = scraper.description_scrape
      description = "As the Norse God of thunder and lightning, Thor wields one of the greatest weapons ever made, the enchanted hammer Mjolnir. While others have described Thor as an over-muscled, oafish imbecile, he's quite smart and compassionate.  He's self-assured, and he would never, ever stop fighting for a worthwhile cause."
      expect(result).to eq(description)
    end
  end
end
