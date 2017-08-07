require "spec_helper"

RSpec.describe "Marvel101::Scraper" do

  describe "#initialize" do
    it "Initializes a Scraper with a url"  do
      new_scrape = Marvel101::Scraper.new("Avengers URL")
      expect(new_scrape.url).to eq("Avengers URL")
    end
  end

end
