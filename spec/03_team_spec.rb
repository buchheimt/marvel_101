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

    it "Initializes with a details array of symbols"  do
      new_team = Marvel101::Team.new("Avengers", "fixtures/avengers.html")
      expect(new_team.details[0]).to eq(:description)
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
  end

end
