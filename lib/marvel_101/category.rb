class Marvel101::Category

  attr_accessor :name, :url, :topics

  def initialize(name, url)
    @name = name
    @url = url
    @topics = Marvel101::Scraper.new(url).scrape_category
  end

end
