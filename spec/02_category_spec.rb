require "spec_helper"

RSpec.describe "Marvel101::Category" do

  describe "#initialize" do
    it "Initializes a Category with a name"  do
      new_category = Marvel101::Category.new("Teams", "http://marvel.com/characters/list/997/titanic_teams")
      expect(new_category.name).to eq("Teams")
    end

    it "Initializes a Category with a url"  do
      new_category = Marvel101::Category.new("Teams", "http://marvel.com/characters/list/997/titanic_teams")
      expect(new_category.url).to eq("marvel url")
    end
  end

end
