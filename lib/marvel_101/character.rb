class Marvel101::Character

  attr_accessor :name, :url, :description, :powers

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @scraped = false
    @@all << self
  end

  def get_info
    attributes = Marvel101::Scraper.new(@url).scrape_character
    attributes.each {|key, value| self.send("#{key}=", value)}
    @scraped = true
  end

  def scraped?
    @scraped
  end

  def self.find_or_create_by_name(name, url)
    search = @@all.detect {|character| character.name == name}
    search ? search : self.new(name, url)
  end

end
