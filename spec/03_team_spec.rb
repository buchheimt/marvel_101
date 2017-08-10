require "spec_helper"

RSpec.describe "Marvel101::Team" do

  describe "#initialize" do
    it "Initializes with a name"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      expect(new_team.name).to eq("Avengers")
    end

    it "Initializes with a url"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      expect(new_team.url).to eq("fixtures/avengers.html")
    end

    it "Initializes with scraped set to false"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      expect(new_team.scraped).to eq(false)
    end

    it "Initializes with a details Constant of symbols"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      expect(Marvel101::Team::DETAILS[0]).to eq(:description)
    end

    it "Adds self to @@all upon initialization"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      expect(Marvel101::Team.all.last).to eq(new_team)
    end
  end

  describe "#get_info" do
    it "retrieves and sets an array of members if applicable"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      new_team.get_info
      expect(new_team.members[0].name).to eq("Black Panther")
    end

    it "retrieves and assigns a description if applicable" do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      new_team.get_info
      description = "Earth's Mightiest Heroes joined forces to take on threats that were too big for any one hero to tackle. With a roster that has included Captain America, Iron Man, Ant-Man, Hulk, Thor, Wasp and dozens more over the years, the Avengers have come to be regarded as Earth's No. 1 team."
      expect(new_team.description).to eq(description)
    end

    it "retrieves and sets a marvel 101 link applicable"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      new_team.get_info
      expect(new_team.url_101).to eq("https://www.youtube.com/watch?v=DLy08aZx5PQ")
    end

    it "retrieves and sets a marvel wiki link if applicable"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      new_team.get_info
      expect(new_team.url_wiki).to eq("http://marvel.com/universe/Avengers")
    end

    it "sets scraped to true" do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      new_team.get_info
      expect(new_team.scraped).to eq(true)
    end

    it "correctly handles missing info" do
      new_team = Marvel101::Team.new("Defenders", "fixtures/defenders.html")
      new_team.get_info
      expect(new_team.url_101).to eq(nil)
    end

    it "correctly handles available info when some is missing" do
      new_team = Marvel101::Team.new("Defenders", "fixtures/defenders.html")
      new_team.get_info
      expect(new_team.url_wiki).to eq("http://marvel.com/universe/Defenders")
    end

    it "sets Characters' list to self.list"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      new_team.list = "Popular Teams"
      new_team.get_info
      expect(new_team.members[0].list).to eq(new_team.list)
    end

    it "sets Characters' team to self"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      new_team.list = "Popular Teams"
      new_team.get_info
      expect(new_team.members[0].team).to eq(new_team)
    end
  end

  describe "self.find_or_create_by_name" do
    it "finds existing team first if possible" do
      pre_count = Marvel101::Team.all.size
      new_team = Marvel101::Team.find_or_create_by_name("Defenders", "fixtures/defenders.html")
      expect(Marvel101::Team.all.size).to eq(pre_count)
    end

    it "creates new team if no team exists" do
      pre_count = Marvel101::Team.all.size
      new_team = Marvel101::Team.find_or_create_by_name("X-Men", "#")
      expect(Marvel101::Team.all.size).to eq(pre_count + 1)
    end
  end
end
