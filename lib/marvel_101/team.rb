class Marvel101::Team

  attr_accessor :name, :url, :scraped, :members, :details, :description, :url_101, :url_wiki

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @scraped = false
    @details = [:description, :url, :url_101, :url_wiki]
    @@all << self
  end

  def get_info
    attributes = Marvel101::Scraper.new(@url).scrape_team
    attributes.each {|key, value| self.send("#{key}=", value)}
    @scraped = true
  end

  def scraped?
    @scraped
  end

  def self.find_or_create_by_name(name, url)
    search = @@all.detect {|team| team.name == name}
    search ? search : self.new(name, url)
  end

end
