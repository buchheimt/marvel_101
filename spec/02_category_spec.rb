require "spec_helper"

RSpec.describe "Marvel101::Category" do

  describe "#initialize" do
    it "Initializes a Category with a name"  do
      new_category = Marvel101::Category.new("Teams", "marvel url")
      expect(new_category.name).to eq("Teams")
    end

    it "Initializes a Category with a url"  do
      new_category = Marvel101::Category.new("Teams", "marvel url")
      expect(new_category.url).to eq("marvel url")
    end
  end

  describe "#add_topics" do
    it "Adds topics to Category" do
      new_category = Marvel101::Category.new("Teams", "marvel url")
      avengers = Marvel101::Team.new("Avengers", ["Thor", "Hulk"], "THE super team", "Avengers HQ")
      new_category.add_topics
      expect(new_category.topics[0].name).to eq("Avengers")
    end

    it "Returns an array of topics" do
      new_category = Marvel101::Category.new("Teams", "marvel url")
      expect(new_category.add_topics).to eq(new_category.topics)
    end
  end

end
