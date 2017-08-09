require "spec_helper"

RSpec.describe "Marvel101::Category" do

  describe "#initialize" do
    it "Initializes a Category with a name"  do
      new_category = Marvel101::Category.new("Popular Teams", "fixtures/teams.html")
      expect(new_category.name).to eq("Popular Teams")
    end

    it "Initializes a Category with a url"  do
      new_category = Marvel101::Category.new("Popular Teams", "fixtures/teams.html")
      expect(new_category.url).to eq("fixtures/teams.html")
    end

    it "Initializes with an array of scraped topics"  do
      new_category = Marvel101::Category.new("Popular Teams", "fixtures/teams.html")
      expect(new_category.topics[0].name).to eq("Avengers")
    end

    it "Adds self to @@all upon initialization"  do
      new_category = Marvel101::Category.new("Popular Teams", "fixtures/avengers.html")
      expect(Marvel101::Category.all.last).to eq(new_category)
    end
  end

end
