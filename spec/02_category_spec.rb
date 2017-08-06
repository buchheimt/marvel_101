require "spec_helper"

RSpec.describe "Marvel101::Category" do

  describe "#initialize" do
    it "Initializes a Category with a name"  do
      new_category = Marvel101::Category.new("Teams")
      expect(new_category.name).to eq("Teams")
    end
  end

end
