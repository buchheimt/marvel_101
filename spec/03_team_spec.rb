require "spec_helper"

RSpec.describe "Marvel101::Team" do

  describe "#initialize" do
    it "Initializes a Team with a name"  do
      new_team = Marvel101::Team.new("Avengers", "Avengers url")
      expect(new_team.name).to eq("Avengers")
    end

    it "Initializes a Team with an array of members"  do
      new_team = Marvel101::Team.new("Avengers", "Avengers url")
      expect(new_team.members[0].name).to eq("Thor")
    end

    it "Initializes a Team with scraped attributes" do
      new_team = Marvel101::Team.new("Avengers", "Avengers url")
      expect(new_team.description).to eq("THE super team")
    end
  end

end
