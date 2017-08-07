class Marvel101::Character

  attr_accessor :name, :url, :details, :description, :real_name, :powers, :abilities, :groups, :first_app, :origin, :url_101, :url_wiki

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @scraped = false
    @details = [:real_name, :description, :powers, :abilities, :groups, :first_app, :origin, :url, :url_101, :url_wiki]
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
