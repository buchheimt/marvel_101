require "spec_helper"

RSpec.describe "Marvel101::Character" do

  describe "#initialize" do
    it "Initializes a Character with a name"  do
      new_char = Marvel101::Character.new("Thor", "Thor url")
      expect(new_char.name).to eq("Thor")
    end
  end

  describe "#get_info" do
    it "retrieves and mass assigns scraped attributes" do
      new_char = Marvel101::Character.new("Thor", "Thor url")
      new_char.get_info
      expect(new_char.description).to eq("God of Thunder")
    end
  end

end
