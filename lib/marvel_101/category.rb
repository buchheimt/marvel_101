class Marvel101::Category

  attr_accessor :name, :url, :topics

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @topics = Marvel101::Scraper.new(url).scrape_category
    @@all << self
  end

  def self.find_or_create_by_name(name, url)
    search = @@all.detect {|category| category.name == name}
    search ? search : self.new(name, url)
  end

  def self.all
    @@all
  end

end
