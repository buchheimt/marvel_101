require "spec_helper"

RSpec.describe "Marvel101::Character" do

  describe "#initialize" do
    it "Initializes with a name"  do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      expect(new_char.name).to eq("Thor")
    end

    it "Initializes with a url"  do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      expect(new_char.url).to eq("fixtures/thor.html")
    end

    it "Initializes with scraped set to false"  do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      expect(new_char.scraped?).to eq(false)
    end

    it "Initializes with a details array of symbols"  do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      expect(new_char.details[0]).to eq(:real_name)
    end

    it "Adds self to @@all upon initialization"  do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      expect(Marvel101::Character.all.last).to eq(new_char)
    end
  end

  describe "#get_info" do
    it "retrieves and assigns a description if applicable" do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      new_char.get_info
      description = "As the Norse God of thunder and lightning, Thor wields one of the greatest weapons ever made, the enchanted hammer Mjolnir. While others have described Thor as an over-muscled, oafish imbecile, he's quite smart and compassionate.  He's self-assured, and he would never, ever stop fighting for a worthwhile cause."
      expect(new_char.description).to eq(description)
    end

    it "retrieves and mass assigns details where available" do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      new_char.get_info
      abilities = "Thor is trained in the arts of war, being a superbly skilled warrior, highly proficient in hand-to-hand combat, swordsmanship and hammer throwing."
      expect(new_char.abilities).to eq(abilities)
    end

    it "retrieves and sets a marvel 101 link applicable"  do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      new_char.get_info
      expect(new_char.url_101).to eq("https://www.youtube.com/watch?v=ZfSBdW6vblc")
    end

    it "retrieves and sets a marvel wiki link if applicable"  do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      new_char.get_info
      expect(new_char.url_wiki).to eq("http://marvel.com/universe/Thor_(Thor_Odinson)")
    end

    it "sets scraped to true" do
      new_char = Marvel101::Character.new("Thor", "fixtures/thor.html")
      new_char.get_info
      expect(new_char.scraped?).to eq(true)
    end

    it "correctly handles missing info" do
      new_char = Marvel101::Character.new("Nova", "fixtures/nova.html")
      new_char.get_info
      expect(new_char.url_wiki).to eq(nil)
    end

    it "correctly handles available info when some is missing" do
      new_char = Marvel101::Character.new("Nova", "fixtures/nova.html")
      new_char.get_info
      expect(new_char.url_101).to eq("https://www.youtube.com/watch?v=cFXqrbLXu3M")
    end
  end

  describe "self.find_or_create_by_name" do
    it "finds existing character first if possible" do
      new_char = Marvel101::Character.find_or_create_by_name("Nova", "fixtures/nova.html")
      expect(new_char.scraped?).to eq(true)
    end

    it "creates new character if no team exists" do
      new_char = Marvel101::Character.find_or_create_by_name("Batman", "#")
      expect(new_char.scraped?).to eq(false)
    end
  end

end
