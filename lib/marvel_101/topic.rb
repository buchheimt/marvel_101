class Marvel101::Topic

  attr_accessor :name, :url, :scraped

  @@all = []

  def initialize(name, url)
    self.name = name
    self.url = url
    self.scraped = false
    self.class.all << self
  end

  def get_info
    scraper = Marvel101::Scraper.new(self)
    self.is_a?(Marvel101::List) ? scraper.scrape_list : scraper.scrape_topic
    self.scraped = true
  end

  def self.find_or_create_by_name(name, url)
    search = self.all.detect {|topic| topic.name == name}
    search ? search : self.new(name, url)
  end

  def self.all
    @@all
  end

end
