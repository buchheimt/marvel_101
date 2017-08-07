class Marvel101::Team

  attr_accessor :name, :members, :description, :location

  def initialize(name, url)
    @name = name
    @url = url
    @scraped = false
  end

  def get_info
    attributes= Marvel101::Scraper.new(@url).scrape_team
    attributes.each {|key, value| self.send("#{key}=", value)}
    @scraped = true
  end

  def scraped?
    @scraped
  end

end
