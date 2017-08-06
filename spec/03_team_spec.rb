require "spec_helper"

RSpec.describe "Marvel101::Team" do

  describe "#initialize" do
    it "Initializes a Team with a name"  do
      new_category = Marvel101::Team.new("Avengers")
      expect(new_category.name).to eq("Avengers")
    end
  end

end
