require "spec_helper"

RSpec.describe "Marvel101::Team" do

  describe "#initialize" do
    it "Initializes a Team with a name"  do
      new_category = Marvel101::Team.new("Avengers", ["Thor", "Hulk", "Iron Man", "Captain America"], "THE super team", "Avengers HQ")
      expect(new_category.name).to eq("Avengers")
    end

    it "Initializes a Team with an array of members"  do
      new_category = Marvel101::Team.new("Avengers", ["Thor", "Hulk", "Iron Man", "Captain America"], "THE super team", "Avengers HQ")
      expect(new_category.members).to eq(["Thor", "Hulk", "Iron Man", "Captain America"])
    end

    it "Initializes a Team with a description"  do
      new_category = Marvel101::Team.new("Avengers", ["Thor", "Hulk", "Iron Man", "Captain America"], "THE super team", "Avengers HQ")
      expect(new_category.description).to eq("THE super team")
    end

    it "Initializes a Team with a location"  do
      new_category = Marvel101::Team.new("Avengers", ["Thor", "Hulk", "Iron Man", "Captain America"], "THE super team", "Avengers HQ")
      expect(new_category.location).to eq("Avengers HQ")
    end
  end

end
