require "spec_helper"

RSpec.describe "Marvel101::Team" do

  new_team = Marvel101::Team.new("Avengers", "http://marvel.com/characters/68/avengers")
  new_team.get_info

  describe "#initialize" do
    it "Initializes a Team with a name"  do
      expect(new_team.name).to eq("Avengers")
    end
  end

  describe "#get_info" do
    it "retrieves and sets an array of members if applicable"  do
      expect(new_team.members[0].name).to eq("Black Panther")
    end

    it "retrieves and assigns a description if applicable" do
      description = "Earth's Mightiest Heroes joined forces to take on threats that were too big for any one hero to tackle. With a roster that has included Captain America, Iron Man, Ant-Man, Hulk, Thor, Wasp and dozens more over the years, the Avengers have come to be regarded as Earth's No. 1 team."
      expect(new_team.description).to eq(description)
    end

    it "retrieves and sets a marvel 101 link applicable"  do
      expect(new_team.url_101).to eq("https://www.youtube.com/watch?v=DLy08aZx5PQ")
    end

    it "retrieves and sets a marvel wiki link if applicable"  do
      expect(new_team.url_wiki).to eq("http://marvel.com/universe/Avengers")
    end
  end

end
