class Marvel101::Team

  attr_accessor :name, :members, :description, :location

  def initialize(name, url)
    @name = name
    @url = url
    attributes, member_names = Marvel101::Scraper.new(url).scrape_team
    attributes.each {|key, value| self.send("#{key}=", value)}
  end

end
