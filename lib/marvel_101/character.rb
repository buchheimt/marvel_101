class Marvel101::Character

  attr_accessor :name, :url, :description, :powers

  def initialize(name, url)
    @name = name
    @url = url
    attributes = Marvel101::Scraper.new(url).scrape_character
    attributes.each {|key, value| self.send("#{key}=", value)}
  end

end
