require "spec_helper"

RSpec.describe "Marvel101::Team" do

  describe "#initialize" do
    it "Initializes a Team with a name"  do
      new_team = Marvel101::Team.new("Avengers", "Avengers url")
      expect(new_team.name).to eq("Avengers")
    end
  end

  describe "#get_info" do
    it "retrieves and sets an array of members to @members"  do
      new_team = Marvel101::Team.new("Avengers", "Avengers url")
      new_team.get_info
      expect(new_team.members[0].name).to eq("Thor")
    end

    it "retrieves and mass assigns scraped attributes" do
      new_team = Marvel101::Team.new("Avengers", "Avengers url")
      new_team.get_info
      expect(new_team.description).to eq("THE super team")
    end
  end

end
