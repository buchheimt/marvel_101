require "spec_helper"

RSpec.describe "Marvel101::List" do

  describe "#initialize" do
    it "Initializes a List with a name"  do
      new_list = Marvel101::List.new("Popular Teams", "fixtures/teams.html")
      expect(new_list.name).to eq("Popular Teams")
    end

    it "Initializes a List with a url"  do
      new_list = Marvel101::List.new("Popular Teams", "fixtures/teams.html")
      expect(new_list.url).to eq("fixtures/teams.html")
    end

    it "Adds self to @@all upon initialization"  do
      new_list = Marvel101::List.new("Popular Teams", "fixtures/teams.html")
      expect(Marvel101::List.all.last).to eq(new_list)
    end

  end

  describe "#get_info" do
    it "Initializes with 'Popular Teams' an array of scraped topics"  do
      new_list = Marvel101::List.new("Popular Teams", "fixtures/teams.html")
      new_list.get_info
      expect(new_list.topics[0].name).to eq("Avengers")
    end

    it "Initializes with 'Popular Heroes' an array of scraped topics"  do
      new_list = Marvel101::List.new("Popular Heroes", "fixtures/heroes.html")
      new_list.get_info
      expect(new_list.topics[0].name).to eq("Spider-Man")
    end

    it "Initializes with 'Featured Characters' an array of scraped topics"  do
      new_list = Marvel101::List.new("Featured Characters", "fixtures/featured.html")
      new_list.get_info
      expect(new_list.topics[0].name).to eq("Black Panther")
    end

    it "sets topics' list to self"  do
      new_list = Marvel101::List.new("Popular Teams", "fixtures/teams.html")
      new_list.get_info
      expect(new_list.topics[0].list).to eq(new_list)
    end
  end

  describe "self.find_or_create_by_name" do
    it "finds existing list first if possible" do
      pre_count = Marvel101::List.all.size
      new_list = Marvel101::List.find_or_create_by_name("Popular Teams", "fixtures/avengers.html")
      expect(Marvel101::List.all.size).to eq(pre_count)
    end

    it "creates new list if no team exists" do
      pre_count = Marvel101::List.all.size
      new_list = Marvel101::List.find_or_create_by_name("Sidekicks", "fixtures/avengers.html")
      expect(Marvel101::List.all.size).to eq(pre_count + 1)
    end
  end

end
