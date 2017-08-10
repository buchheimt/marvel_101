require "spec_helper"

RSpec.describe "Marvel101::Scraper" do

  describe "#initialize" do
    it "Initializes a Scraper with a url"  do
      new_scrape = Marvel101::Scraper.new("Avengers URL")
      expect(new_scrape.url).to eq("Avengers URL")
    end
  end

  describe "#scrape_list" do
    it "returns an array of teams when passed the team page url" do
      info = Marvel101::Scraper.new('fixtures/teams.html').scrape_list
      expect(info[0].is_a?(Marvel101::Team)).to eq(true)
    end

    it "properly instantiates new teams" do
      new_list = Marvel101::Scraper.new('fixtures/teams.html').scrape_list
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      expect(new_list[0].description).to eq(new_team.description)
    end

    it "returns an array of characters when passed a character url" do
      info = Marvel101::Scraper.new('fixtures/heroes.html').scrape_list
      expect(info[0].is_a?(Marvel101::Character)).to eq(true)
    end

    it "properly instantiates new characters" do
      new_list = Marvel101::Scraper.new('fixtures/heroes.html').scrape_list
      new_character = Marvel101::Character.new("Spider-Man", "fixtures/heroes.html")
      expect(new_list[0].description).to eq(new_character.description)
    end
  end

  describe '#scrape_topic' do
    it "retrieves a description for a team if applicable" do
      scraper = Marvel101::Scraper.new("fixtures/avengers.html")
      team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      description = "Earth's Mightiest Heroes joined forces to take on threats that were too big for any one hero to tackle. With a roster that has included Captain America, Iron Man, Ant-Man, Hulk, Thor, Wasp and dozens more over the years, the Avengers have come to be regarded as Earth's No. 1 team."
      expect(team.description).to eq(description)
    end

    it "handles no description for a team" do
      scraper = Marvel101::Scraper.new("fixtures/defenders.html")
      team = Marvel101::Team.new("Defenders", "fixtures/avengers.html")
      expect(info.include?(:description)).to eq(false)
    end

    it "returns an array of characters when possible" do
      scraper = Marvel101::Scraper.new("fixtures/avengers.html")
      info = scraper.scrape_team
      expect(info[:members][0].name).to eq("Black Panther")
    end

    it "properly instantiates new characters" do
      scraper = Marvel101::Scraper.new("fixtures/avengers.html")
      info = scraper.scrape_team
      expect(info[:members][0].is_a?(Marvel101::Character)).to eq(true)
    end

    it "handles no member info" do
      scraper = Marvel101::Scraper.new("fixtures/defenders.html")
      info = scraper.scrape_team
      expect(info.include?(:members)).to eq(false)
    end

    it "retrieves a marvel 101 link if applicable"  do
      scraper = Marvel101::Scraper.new("fixtures/avengers.html")
      info = scraper.scrape_team
      expect(info[:url_101]).to eq("https://www.youtube.com/watch?v=DLy08aZx5PQ")
    end

    it "retrieves a marvel wiki link if applicable"  do
      scraper = Marvel101::Scraper.new("fixtures/avengers.html")
      info = scraper.scrape_team
      expect(info[:url_wiki]).to eq("http://marvel.com/universe/Avengers")
    end

    it "handles no marvel wiki url" do
      scraper = Marvel101::Scraper.new("fixtures/inhumans.html")
      info = scraper.scrape_team
      expect(info.include?(:url_wiki)).to eq(false)
    end

    it "handles no marvel 101 url" do
      scraper = Marvel101::Scraper.new("fixtures/defenders.html")
      info = scraper.scrape_team
      expect(info.include?(:url_101)).to eq(false)
    end
  end

  describe '#scrape_character' do
    it "retrieves a description if applicable" do
      scraper = Marvel101::Scraper.new("fixtures/thor.html")
      info = scraper.scrape_character
      description = "As the Norse God of thunder and lightning, Thor wields one of the greatest weapons ever made, the enchanted hammer Mjolnir. While others have described Thor as an over-muscled, oafish imbecile, he's quite smart and compassionate.  He's self-assured, and he would never, ever stop fighting for a worthwhile cause."
      expect(info[:description]).to eq(description)
    end

    it "handles no description" do
      scraper = Marvel101::Scraper.new("fixtures/gambit.html")
      info = scraper.scrape_character
      expect(info.include?(:description)).to eq(false)
    end

    it "retrieves a marvel 101 link if applicable"  do
      scraper = Marvel101::Scraper.new("fixtures/thor.html")
      info = scraper.scrape_character
      expect(info[:url_101]).to eq("https://www.youtube.com/watch?v=ZfSBdW6vblc")
    end

    it "retrieves a marvel wiki link if applicable"  do
      scraper = Marvel101::Scraper.new("fixtures/thor.html")
      info = scraper.scrape_character
      expect(info[:url_wiki]).to eq("http://marvel.com/universe/Thor_(Thor_Odinson)")
    end

    it "handles no marvel wiki url" do
      scraper = Marvel101::Scraper.new("fixtures/gambit.html")
      info = scraper.scrape_character
      expect(info.include?(:url_wiki)).to eq(false)
    end

    it "handles no marvel 101 url" do
      scraper = Marvel101::Scraper.new("fixtures/gambit.html")
      info = scraper.scrape_character
      expect(info.include?(:url_101)).to eq(false)
    end

    it "retrieves info for mass assignment" do
      scraper = Marvel101::Scraper.new("fixtures/thor.html")
      info = scraper.scrape_character
      expect(info[:real_name]).to eq("Thor Odinson")
    end

    it "handles missing mass assignment info" do
      scraper = Marvel101::Scraper.new("fixtures/nova.html")
      info = scraper.scrape_character
      expect(info.include?(:real_name)).to eq(false)
    end
  end

  describe '#description_scrape' do
    it "returns the correctly formatted string for teams" do
      scraper = Marvel101::Scraper.new("fixtures/avengers.html")
      doc = Nokogiri::HTML(open("fixtures/avengers.html"))
      result = scraper.description_scrape(doc)
      description = "Earth's Mightiest Heroes joined forces to take on threats that were too big for any one hero to tackle. With a roster that has included Captain America, Iron Man, Ant-Man, Hulk, Thor, Wasp and dozens more over the years, the Avengers have come to be regarded as Earth's No. 1 team."
      expect(result).to eq(description)
    end

    it "returns the correctly formatted string for characters" do
      scraper = Marvel101::Scraper.new("fixtures/thor.html")
      doc = Nokogiri::HTML(open("fixtures/thor.html"))
      result = scraper.description_scrape(doc)
      description = "As the Norse God of thunder and lightning, Thor wields one of the greatest weapons ever made, the enchanted hammer Mjolnir. While others have described Thor as an over-muscled, oafish imbecile, he's quite smart and compassionate.  He's self-assured, and he would never, ever stop fighting for a worthwhile cause."
      expect(result).to eq(description)
    end

  end

end
