class Marvel101::Topic

  attr_accessor :name, :url, :scraped

  @@all = []

  def initialize(name, url)
    @name = name
    @url = url
    @scraped = false
    @@all << self
  end

  def get_info
    scraper = Marvel101::Scraper.new(self)
    self.is_a?(Marvel101::List) ? scraper.scrape_list : scraper.scrape_topic
    @scraped = true
  end

  def self.find_or_create_by_name(name, url)
    search = @@all.detect {|topic| topic.name == name}
    search ? search : self.new(name, url)
  end

  def self.all
    @@all
  end

end
