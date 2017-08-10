class Marvel101::Topic

  attr_accessor :name, :description, :urls, :scraped

  @@all = []

  def initialize(name, url)
    @name = name
    @urls = {url: url}
    @scraped = false
    @@all << self
  end

  def get_info
    scraper = Marvel101::Scraper.new(self)
    self.list? ? scraper.scrape_list : scraper.scrape_topic
    @scraped = true
  end

  def display_description
    puts "DESCRIPTION: #{description}" if description
  end

  def display_links
    puts "" if urls.size > 1
    puts "Marvel Wiki page available! Type 'wiki' to open in browser" if urls.include?(:url_wiki)
    puts "Marvel 101 video available! Type '101' to open in browser" if urls.include?(:url_101)
  end

  def list?
    self.is_a?(Marvel101::List)
  end

  def team?
    self.is_a?(Marvel101::Team)
  end

  def char?
    self.is_a?(Marvel101::Character)
  end

  def self.find_or_create_by_name(name, url)
    search = @@all.detect {|topic| topic.name == name}
    search ? search : self.new(name, url)
  end

  def self.all
    @@all
  end
end
