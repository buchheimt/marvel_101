class Marvel101::Scraper

  attr_accessor :url

  def initialize(url)
    @url = url
  end

  def scrape_category
    case url
    when "Teams url"
      topics = []
      topics << Marvel101::Team.new("Avengers", ["Thor", "Hulk", "Iron Man", "Captain America"], "THE super team", "Avengers HQ")
      topics << Marvel101::Team.new("X-Men", ["Wolverine", "Cyclops", "Jean Gray"], "Vast team of gifted mutants", "Xavier's Academy")
      topics << Marvel101::Team.new("Guardians of the Galaxy", ["Groot", "Star Lord", "Drax"], "Intergalactic band of misfits", "The universe")
      topics
    end
  end

end
