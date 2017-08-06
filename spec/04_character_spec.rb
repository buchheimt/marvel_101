require "spec_helper"

RSpec.describe "Marvel101::Team" do

  describe "#initialize" do
    it "Initializes a Character with a name"  do
      new_char = Marvel101::Character.new("Thor")
      expect(new_char.name).to eq("Thor")
    end
  end

end
