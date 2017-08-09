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

    it "Initializes with 'Popular Teams' an array of scraped topics"  do
      new_category = Marvel101::Category.new("Popular Teams", "fixtures/teams.html")
      expect(new_category.topics[0].name).to eq("Avengers")
    end

    it "Initializes with 'Popular Heroes' an array of scraped topics"  do
      new_category = Marvel101::Category.new("Popular Heroes", "fixtures/heroes.html")
      expect(new_category.topics[0].name).to eq("Spider-Man")
    end

    it "Initializes with 'Featured Characters' an array of scraped topics"  do
      new_category = Marvel101::Category.new("Featured Characters", "fixtures/featured.html")
      expect(new_category.topics[0].name).to eq("Black Panther")
    end

    it "Adds self to @@all upon initialization"  do
      new_category = Marvel101::Category.new("Popular Teams", "fixtures/teams.html")
      expect(Marvel101::Category.all.last).to eq(new_category)
    end

    it "sets topics' category to self"  do
      new_category = Marvel101::Category.new("Popular Teams", "fixtures/teams.html")
      expect(new_category.topics[0].category).to eq(new_category)
    end
  end

  describe "self.find_or_create_by_name" do
    it "finds existing category first if possible" do
      pre_count = Marvel101::Category.all.size
      new_category = Marvel101::Category.find_or_create_by_name("Popular Teams", "fixtures/avengers.html")
      expect(Marvel101::Category.all.size).to eq(pre_count)
    end

    it "creates new category if no team exists" do
      pre_count = Marvel101::Category.all.size
      new_category = Marvel101::Category.find_or_create_by_name("Sidekicks", "fixtures/avengers.html")
      expect(Marvel101::Category.all.size).to eq(pre_count + 1)
    end
  end

end
